from django.shortcuts import render, render_to_response, RequestContext

from django.shortcuts import render_to_response, get_object_or_404
from .models import computerlab, instructor, sandbox, faculty
from django.template import Context, loader, RequestContext
from django.http import HttpResponseRedirect, HttpResponse
from django.core.urlresolvers import reverse
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import logout_then_login
from django.contrib.auth import logout
from django.contrib.auth.models import User
from django.db.models import Q

import os
import time
import boto
import boto.manage.cmdshell
import boto.manage.server
import boto.ec2.cloudwatch
import re


# Create your views here.
def home(request):
    return render_to_response("signup.html",
                              locals(),
                              context_instance=RequestContext(request))


def logout_view(request):
    logout(request)
    # return HttpResponseRedirect('registration/logout.html')
    return render_to_response('registration/logout.html', locals(),
                              context_instance=RequestContext(request))


@login_required(login_url='/accounts/login/')
def index(request):
    myuser = request.user
    action = 'Do Nothing'
    result = ''
    if 'iid' in request.POST:
        iid = request.POST['iid']
        if 'action' in request.POST:
            action = request.POST['action']
            if action == 'Start Server':
                result = start_instance(iid)
            if action == 'Stop Server':
                result = stop_instance(iid)
            if action == 'Create Server':
                iitype = str(request.POST['instance_type'])
                iid = request.POST['iid']
                coursecode = request.POST['coursecode']
                instructor_id = request.POST['instructor_id']
                credentials = request.POST['lab_auth_info']

#                if iitype == 't1.micro':
#                  iitype = 't2.micro'
#                if iitype == 'm1.small':
#                  iitype = 'm2.small'
#                if iitype == 'm1.medium':
#                  iitype = 'm2.medium'

                try:
                    result = create_instance(username=myuser.username,
                                             ami=iid,
                                             instance_type=iitype,
                                             classcode=coursecode,
                                             instructor_id=instructor_id,
                                             credentials=credentials)
                except:
                    iitype = 't2.micro'
                    result = create_instance(username=myuser.username,
                                             ami=iid,
                                             instance_type=iitype,
                                             classcode=coursecode,
                                             instructor_id=instructor_id,
                                             credentials=credentials)
            if action == 'Terminate Server':
                instructor.objects.filter(instance_id=iid).delete()
                result = terminate_instance(iid)
            if action == 'Download Connection File':
                public_dns = request.POST['public_dns']
                result = create_rdp_file(public_dns)

    error_msg = ''
    if result == "IntegrityError":
        error_msg = 'Only one server is allowed per course'

    list_of_machines = list_instances(username=myuser.username)
    list_of_labs = computerlab.objects.all()
    is_instructor = "no"
    check_instructor = computerlab.objects.filter(
            instructor_id=myuser.username
        )
    check_instructor = computerlab.objects.filter(
            Q(instructor_id=myuser.username) |
            Q(instructor2_id=myuser.username) |
            Q(instructor3_id=myuser.username)
        )
    if check_instructor.count() > 0:
        is_instructor = "yes"
    # my_lab_info = computerlab.objects.get(
    #        amazonami=list_of_machines['ami_id']
    #    )
    return render_to_response(
            'lab/index.html',
            {'list_of_machines': list_of_machines,
             "is_instructor": is_instructor,
             'error_msg': error_msg,
             'myuser': myuser,
             'action': action,
             'list_of_labs': list_of_labs},
            context_instance=RequestContext(request)
        )
    # output =  'Your instance is ready to use!
    #            RDP or SSH to: ',instance.dns_name
    # return HttpResponseRedirect(reverse(
    #            'lab.index', args=(output,)))

###################################################
#                                                 #
# code from vcl                                   #
#                                                 #
###################################################


def create_instance(
        ami='ami-ddb239b4',
        instance_type='t1.micro',
        # key_name='aws_vcl_key',
        key_name='instance_key',
        key_extension='.pem',
        key_dir='~/.ssh',
        # key_dir='/home/infoadmin/keys',
        group_name='default',
        ssh_port=22,
        cidr='0.0.0.0/0',
        tag='LBSC_670',
        user_data=None,
        cmd_shell=True,
        login_user='ubuntu',
        ssh_passwd=None,
        username='',
        classcode='iSchool',
        instructor_id='',
        credentials='',
        azone='us-east-1c'):

    """
    Launch an instance and wait for it to start running.
    Returns a tuple consisting of the Instance object and the CmdShell
    object, if request, or None.

    ami        The ID of the Amazon Machine Image that this instance will
               be based on.  Default is a 64-bit Amazon Linux EBS image.

    instance_type The type of the instance.

    key_name   The name of the SSH Key used for logging into the instance.
               It will be created if it does not exist.

    key_extension The file extension for SSH private key files.

    key_dir    The path to the directory containing SSH private keys.
               This is usually ~/.ssh.

    group_name The name of the security group used to control access
               to the instance.  It will be created if it does not exist.

    ssh_port   The port number you want to use for SSH access (default 22).

    cidr       The CIDR block used to limit access to your instance.

    tag        A name that will be used to tag the instance so we can
               easily find it later.

    user_data  Data that will be passed to the newly started
               instance at launch and will be accessible via
               the metadata service running at http://169.254.169.254.

    cmd_shell  If true, a boto CmdShell object will be created and returned.
               This allows programmatic SSH access to the new instance.

    login_user The user name used when SSH'ing into new instance.  The
               default is 'ec2-user'

    ssh_passwd The password for your SSH key if it is encrypted with a
               passphrase.
    """
    cmd = None
    user_data = """#!/bin/bash
set -e -x
export DEBIAN_FRONTEND=noninteractive
apt-get --yes remove --force-yes freenx-server
apt-get install --force-yes freenx-server
"""
    # user_data =
    #   "apt-get install -o Dpkg::Options::='--force-confdef' \
    #   -o Dpkg::Options::='--force-confold'  -f -q -y freenx-server"
    # new_register =
    #   instructor(instructor_id=instructor_id,course_id=classcode,student_id=username)

    aws_conn = boto.ec2.connection.EC2Connection()
    student_records = instructor.objects.filter(
            course_id=classcode, student_id=username
        )
    for student in student_records:
        try:
            res = aws_conn.get_all_instances(
                    instance_ids=[student.instance_id]
                    )
            instances = [i for r in res for i in r.instances]
            for i in instances:
                if str(i._state) == 'terminated(48)':
                    instructor.objects.filter(
                            instance_id=student.instance_id
                        ).delete()
        except:
            instructor.objects.filter(instance_id=student.instance_id).delete()

    count_of_records = instructor.objects.filter(
            course_id=classcode,
            student_id=username
        ).count()

    if count_of_records > 0:
        return "IntegrityError"

    # Create a connection to EC2 service.
    # You can pass credentials in to the connect_ec2 method explicitly
    # or you can use the default credentials in your ~/.boto config file
    # as we are doing here.
    ec2 = boto.connect_ec2()

    # Check to see if specified keypair already exists.
    # If we get an InvalidKeyPair.NotFound error back from EC2,
    # it means that it doesn't exist and we need to create it.
    try:
        key = ec2.get_all_key_pairs(keynames=[key_name])[0]
    except ec2.ResponseError, e:
        if e.code == 'InvalidKeyPair.NotFound':
            print 'Creating keypair: %s' % key_name
            # Create an SSH key to use when logging into instances.
            key = ec2.create_key_pair(key_name)

            # AWS will store the public key but the private key is
            # generated and returned and needs to be stored locally.
            # The save method will also chmod the file to protect
            # your private key.
            key.save(key_dir)
        else:
            raise

    # Check to see if specified security group already exists.
    # If we get an InvalidGroup.NotFound error back from EC2,
    # it means that it doesn't exist and we need to create it.
    try:
        group = ec2.get_all_security_groups(groupnames=[group_name])[0]
    except ec2.ResponseError, e:
        if e.code == 'InvalidGroup.NotFound':
            print 'Creating Security Group: %s' % group_name
            # Create a security group to control access to instance via SSH.
            group = ec2.create_security_group(group_name,
                                              'A group that allows SSH access')
        else:
            raise

    # Add a rule to the security group to authorize SSH traffic
    # on the specified port.
    try:
        group.authorize('tcp', ssh_port, ssh_port, cidr)
    except ec2.ResponseError, e:
        if e.code == 'InvalidPermission.Duplicate':
            print 'Security Group: %s already authorized' % group_name
        else:
            raise

    # find the volume for the user and class in question
    # volumes = ec2.get_all_volumes(
    #     filters={'tag-value': username, 'tag-value':classcode}
    #     )
    # Attach the volume to the server
    # result = volumes.attach(instance, '/dev/sdf')
    # define user data to mount the volume
    # Now start up the instance.  The run_instances method
    # has many, many parameters but these are all we need
    # for now.
    reservation = ec2.run_instances(ami,
                                    key_name=key_name,
                                    security_groups=[group_name],
                                    instance_type=instance_type,
                                    user_data=user_data,
                                    placement=azone)

    # Find the actual Instance object inside the Reservation object
    # returned by EC2.

    instance = reservation.instances[0]
    machinename = classcode + "--" + username + "--Instructor:" + instructor_id
    # Add user tags to it
    instance.add_tag('username', username)
    instance.add_tag('classcode', classcode)
    instance.add_tag('Name', machinename)

    # The instance has been launched but it's not yet up and
    # running.  Let's wait for its state to change to 'running'.

    print 'waiting for instance'
    while instance.state != 'running':
        print '.'
        time.sleep(5)
        instance.update()

    create_status_alarm(instance.id)

    new_register = instructor(
            instance_id=instance.id,
            instructor_id=instructor_id,
            course_id=classcode,
            student_id=username,
            credentials=credentials
        )
    new_register.save()

    return (
        'Your instance has been created and is running at',
        instance.dns_name,
        '  Please use NX Viewer or remote desktop to connect.'
        )


def create_rdp_file(request):
    from django.http import HttpResponse
    # import StringIO
    import csv
    public_dns = request.GET['public_dns']

    lab_auth_info = request.GET['lab_auth_info']
    try:
            find = re.compile(r"^[^,]*")
            regex1 = re.search(find, lab_auth_info).group(0)
            regex2 = regex1.split('=')
            username = regex2[1].strip()
    except:
            username = ""

    import cStringIO as StringIO
    # response = HttpResponse(tmpfile, content_type="application/x-rdp")
    # response['Content-Disposition'] = 'attachment; filename=connect.rdp'
    # writer = csv.writer(response)
    # myfile = StringIO.StringIO(response)
    tmpfile = """ screen mode id:i:1
desktopwidth:i:1280
desktopheight:i:720
session bpp:i:32
auto connect:i:1
compression:i:1
keyboardhook:i:2
audiomode:i:2
redirectdrives:i:0
redirectprinters:i:0
redirectcomports:i:0
redirectsmartcards:i:0
displayconnectionbar:i:1
username:s:{0}
domain:s:
alternate shell:s:
shell working directory:s:
disable wallpaper:i:1
disable full window drag:i:1
disable menu anims:i:1
disable themes:i:1
bitmapcachepersistenable:i:1
full address:s:%s
""" % (public_dns)

    # tmpfile = tmpfile+"full address:s:"+public_dns
    # writer.writerow([tmpfile])
    tmpfile = tmpfile.format(username)
    find = re.compile(r"^[^.]*")
    filename = re.search(find, public_dns).group(0)
    filename = filename + ".rdp"
    response = HttpResponse(tmpfile, content_type="application/x-rdp")
    response['Content-Disposition'] = "attachment; filename=" + filename
    return response


def start_instance(iid):
    ec2 = boto.connect_ec2()
    reservations = ec2.get_all_instances(filters={'instance-id': iid})
    instance = reservations[0].instances[0]
    iid = [instance.id]
    instance_state = ec2.start_instances(iid)
    while instance.state != 'running':
        print '.'
        time.sleep(5)
        instance.update()


def stop_instance(iid):
    ec2 = boto.connect_ec2()
    reservations = ec2.get_all_instances(filters={'instance-id': iid})
    instance = reservations[0].instances[0]
    iid = [instance.id]
    instance_state = ec2.stop_instances(iid)
    while instance.state != 'stopped':
        print '.'
        time.sleep(5)
        instance.update()


def terminate_instance(iid):
    ec2 = boto.connect_ec2()
    reservations = ec2.get_all_instances(filters={'instance-id': iid})
    instance = reservations[0].instances[0]
    delete_status_alarm(iid)
    iid = [instance.id]
    instance_state = ec2.terminate_instances(iid)
    while instance.state != 'terminated':
        print '.'
        time.sleep(5)
        instance.update()


def list_instances(ami='ami-',
                   instance_type='t1.micro',
                   key_name='instance_key',
                   key_extension='.pem',
                   key_dir='~/.ssh',
                   # key_dir='/home/infoadmin/keys',
                   group_name='vcl_lab',
                   ssh_port=22,
                   cidr='0.0.0.0/0',
                   tag='LBSC_670',
                   user_data=None,
                   cmd_shell=True,
                   login_user='ubuntu',
                   ssh_passwd=None,
                   username='',
                   classcode='',
                   azone='us-east-1c'):
    ec2 = boto.connect_ec2()
    reservations = ec2.get_all_instances(filters={'tag-value': username})
    machines = {}
    for reservation in reservations:
        instance = reservation.instances[0]
        instance_tags = instance.tags
        if instance_tags[u'Name']:
            instance_name = instance_tags[u'Name']
        else:
            instance_name = "Lab machine"
        if instance.state != 'terminated':
            tmpinstance = str(instance.image_id)
            # comp_lab_info = {
            # 'lab_auth_info':
            # 'Sorry, I could not find any authentication information',
            # 'lab_connection_options':
            # 'Sorry, I could not find connection options!'}
            try:
                comp_lab_info = computerlab.objects.get(amazonami=tmpinstance)
                lab_auth_info = comp_lab_info.lab_auth_info
                connect_info = comp_lab_info.lab_connection_options
                coursecode = comp_lab_info.coursecode
            except Exception:
                comp_lab_info = {'lab_auth_info': 'simple',
                                 'lab_connection_options': 'test2'}
                lab_auth_info = comp_lab_info['lab_auth_info']
                coursecode = 'none'
                connect_info = comp_lab_info['lab_connection_options']

            try:
                fetch_status = ec2.get_all_instance_status(
                        instance_ids=instance.id
                        )
                machine_status = fetch_status[0].system_status.details[
                        'reachability'
                        ]
            except:
                machine_status = "stopped"
            machines[instance.id] = {
                    'instance_name': instance_name,
                    'coursecode': coursecode,
                    'instance_type': instance.instance_type,
                    'lab_auth_info': lab_auth_info,
                    'instance_id': instance.id,
                    'connect_info': connect_info,
                    'instance_state': instance.state,
                    'ami_id': instance.image_id,
                    'machine_status': machine_status,
                    'public_dns': instance.public_dns_name,
                    'insert': str(instance_name)}

    return machines


def create_status_alarm(instance_id):
    ec2_conn = boto.ec2.connect_to_region("us-east-1")

    cloudwatch_conn = boto.ec2.cloudwatch.connect_to_region("us-east-1")

    reservations = ec2_conn.get_all_instances(
            filters={'instance-id': instance_id}
            )
    if reservations and reservations[0].instances:
        instance = reservations[0].instances[0]
        instance_name = instance.tags['Name']
    else:
        print "Invalid instance-id!"
        sys.exit(1)
    alarm = boto.ec2.cloudwatch.alarm.MetricAlarm(
        connection=cloudwatch_conn,
        name=instance_id + " : " +
        instance_name + "-CPU Utilization less than 5%",
        metric='CPUUtilization',
        namespace='AWS/EC2',
        statistic='Maximum',
        comparison='<=',
        description='Alarm that triggers when the '
        'instance CPU goes less than 5% for 1 hour',
        threshold=5,
        period=3600,
        evaluation_periods=2,
        dimensions={'InstanceId': instance_id},
        alarm_actions='arn:aws:automate:us-east-1:ec2:stop',
    )
    cloudwatch_conn.put_metric_alarm(alarm)


def delete_status_alarm(instance_id):
    ec2_conn = boto.ec2.connect_to_region("us-east-1")

    cloudwatch_conn = boto.ec2.cloudwatch.connect_to_region("us-east-1")

    reservations = ec2_conn.get_all_instances(
            filters={'instance-id': instance_id}
            )
    if reservations and reservations[0].instances:
        instance = reservations[0].instances[0]
        instance_name = instance.tags['Name']
    else:
        print "Invalid instance-id!"

    alarm_name = instance_id + " : " + \
        instance_name + "-CPU Utilization less than 10%"
    list_alarms = []
    list_alarms.append(alarm_name)
    cloudwatch_conn.delete_alarms(list_alarms)


@login_required(login_url='/accounts/login/')
def tutor(request):
    myuser = request.user
    action = 'Do Nothing'
    course = ''
    if request.method == 'GET' and 'course' in request.GET:
        course = request.GET['course']

    list_of_students = instructor.objects.filter(instructor_id=myuser.username)

    student_instance_ids = []
    course_list = []

    for student in list_of_students:
        student_instance_ids.append(student.instance_id)
        course_list.append(student.course_id)

    course_list = list(set(course_list))

    if len(course) > 0:
        list_of_students = instructor.objects.filter(
                instructor_id=myuser.username, course_id=course
                )

    final_student_instance_ids = []
    aws_conn = boto.ec2.connection.EC2Connection()
    for inst in student_instance_ids:
        try:
            res = aws_conn.get_all_instances(instance_ids=[inst])
            final_student_instance_ids.append(inst)
        except:
            instructor.objects.filter(instance_id=inst).delete()

    instance_states = {}
#    aws_conn = boto.ec2.connection.EC2Connection()
    res = aws_conn.get_all_instances(instance_ids=final_student_instance_ids)
    instances = [i for r in res for i in r.instances]
    for i in instances:
        instance_states[i.id] = {
                'instance_state': i._state, 'public_dns': i.public_dns_name
                }

    student_data = []
    for student in list_of_students:
        try:
            student_data.append({"course_id": student.course_id,
                                 "student_id": student.student_id,
                                 "credentials": student.credentials,
                                 "instance_state": str(
                                    instance_states[student.instance_id]
                                                   ['instance_state']
                                    ),
                                 "dsn": instance_states[student.instance_id]
                                                       ['public_dns']}
                                )
        except:
            continue
    student_data = sorted(student_data, key=lambda k: k['instance_state'])

    if 'action' in request.POST:
        public_dns = request.POST['public_dns']
        result = create_rdp_file(public_dns)
    return render_to_response('lab/instructor.html',
                              {'student_data': student_data,
                               'course_list': course_list,
                               'myuser': myuser,
                               'action': action},
                              context_instance=RequestContext(request))


def group1(request):
    myuser = request.user
    action = 'Do Nothing'
    course = ''
    if request.method == 'GET' and 'course' in request.GET:
        course = request.GET['course']

    list_of_students = instructor.objects.filter(instructor_id=myuser.username)

    student_instance_ids = []
    course_list = []

    for student in list_of_students:
        student_instance_ids.append(student.instance_id)
        course_list.append(student.course_id)

    course_list = list(set(course_list))

    if len(course) > 0:
        list_of_students = instructor.objects.filter(
                instructor_id=myuser.username, course_id=course
                )

    instance_states = {}
    aws_conn = boto.ec2.connection.EC2Connection()
    res = aws_conn.get_all_instances(instance_ids=student_instance_ids)
    instances = [i for r in res for i in r.instances]
    for i in instances:
        instance_states[i.id] = {'instance_state': i._state,
                                 'public_dns': i.public_dns_name}

    student_data = []
    for student in list_of_students:
        student_data.append({"course_id": student.course_id,
                             "student_id": student.student_id,
                             "credentials": student.credentials,
                             "instance_state": str(
                                 instance_states[student.instance_id]
                                                ['instance_state']),
                             "dsn": instance_states[student.instance_id]
                                                   ['public_dns']}
                            )
    student_data = sorted(student_data, key=lambda k: k['instance_state'])

    if 'action' in request.POST:
        public_dns = request.POST['public_dns']
        result = create_rdp_file(public_dns)
    return render_to_response('lab/groups.html',
                              {'student_data': student_data,
                               'course_list': course_list,
                               'myuser': myuser,
                               'action': action},
                              context_instance=RequestContext(request)
                              )


@login_required(login_url='/accounts/login/')
def groups(request):
    myuser = request.user
    action = 'Do Nothing'
    result = ''
    coursecode = ''
    group_size = ''
    iid = ''
    data = ''
    if 'iid' in request.POST:
        iid = request.POST['iid']
        if 'action' in request.POST:
            action = request.POST['action']
            if action == 'Start Server':
                result = start_instance(iid)
            if action == 'Stop Server':
                result = stop_instance(iid)
            if action == 'Create Server':
                iid = request.POST['iid']
                student_group = request.POST['gname']
                group_size = int(request.POST['box-0'])
                student_ids = []
                for num in range(1, group_size+1):
                        box = "box-" + str(num)
                        student_id = request.POST[box]
                        student_ids.append(student_id)
                course_code = list(computerlab.objects.values_list(
                    'coursecode', flat=True).filter(amazonami=iid))
                instance_type = list(computerlab.objects.values_list(
                    'instance_type', flat=True).filter(amazonami=iid))

                result = create_shared_machine(student_ids=student_ids,
                                               ami=iid,
                                               instance_type=str(
                                                   instance_type[0]),
                                               classcode=str(
                                                   course_code[0]),
                                               student_group=student_group
                                               )

            if action == 'Create Sandbox':
                iid = request.POST['iid']
                student_group = request.POST['gname']
                group_size = int(request.POST['box-0'])
                student_ids = []
                for num in range(1, group_size+1):
                        box = "box-" + str(num)
                        student_id = request.POST[box]
                        student_ids.append(student_id)
                course_code = list(
                        sandbox.objects.values_list(
                            'labname',
                            flat=True
                            ).filter(amazonami=iid))
                instance_type = list(
                        sandbox.objects.values_list(
                            'instance_type',
                            flat=True
                            ).filter(amazonami=iid))

                result = create_shared_machine(
                        student_ids=student_ids,
                        ami=iid,
                        instance_type=str(instance_type[0]),
                        classcode=str(course_code[0]),
                        student_group=student_group
                        )

            if action == 'Terminate Server':
                instructor.objects.filter(instance_id=iid).delete()
                result = terminate_instance(iid)
            if action == 'Download Connection File':
                public_dns = request.POST['public_dns']
                result = create_rdp_file(public_dns)

    error_msg = data

    list_of_machines = list_shared_instances(username=myuser.username)
    list_of_labs = computerlab.objects.all()
    list_of_sandbox = sandbox.objects.all()
    is_instructor = "no"
    check_instructor = computerlab.objects.filter(
            instructor_id=myuser.username
            )
    check_instructor = computerlab.objects.filter(
            Q(instructor_id=myuser.username) |
            Q(instructor2_id=myuser.username) |
            Q(instructor3_id=myuser.username)
            )
    if check_instructor.count() > 0:
        is_instructor = "yes"
    return render_to_response(
            'lab/groups_new.html',
            {'list_of_machines': list_of_machines,
             'list_of_sandbox': list_of_sandbox,
             "is_instructor": is_instructor,
             'error_msg': error_msg,
             'myuser': myuser,
             'action': action,
             'list_of_labs': list_of_labs},
            context_instance=RequestContext(request)
            )


def create_shared_machine(ami='ami-ddb239b4',
                          instance_type='t1.micro',
                          # key_name='aws_vcl_key',
                          key_name='instance_key',
                          key_extension='.pem',
                          key_dir='~/.ssh',
                          # key_dir='/home/infoadmin/keys',
                          group_name='default',
                          ssh_port=22,
                          cidr='0.0.0.0/0',
                          tag='LBSC_670',
                          user_data=None,
                          cmd_shell=True,
                          login_user='ubuntu',
                          ssh_passwd=None,
                          username='',
                          classcode='iSchool',
                          student_group='',
                          student_ids=[],
                          azone='us-east-1c'):

    ec2 = boto.connect_ec2()

    # Check to see if specified keypair already exists.
    # If we get an InvalidKeyPair.NotFound error back from EC2,
    # it means that it doesn't exist and we need to create it.
    try:
        key = ec2.get_all_key_pairs(keynames=[key_name])[0]
    except ec2.ResponseError, e:
        if e.code == 'InvalidKeyPair.NotFound':
            print 'Creating keypair: %s' % key_name
            # Create an SSH key to use when logging into instances.
            key = ec2.create_key_pair(key_name)

            # AWS will store the public key but the private key is
            # generated and returned and needs to be stored locally.
            # The save method will also chmod the file to protect
            # your private key.
            key.save(key_dir)
        else:
            raise

    # Check to see if specified security group already exists.
    # If we get an InvalidGroup.NotFound error back from EC2,
    # it means that it doesn't exist and we need to create it.
    try:
        group = ec2.get_all_security_groups(groupnames=[group_name])[0]
    except ec2.ResponseError, e:
        if e.code == 'InvalidGroup.NotFound':
            print 'Creating Security Group: %s' % group_name
            # Create a security group to control access to instance via SSH.
            group = ec2.create_security_group(group_name,
                                              'A group that allows SSH access')
        else:
            raise

    # Add a rule to the security group to authorize SSH traffic
    # on the specified port.
    try:
        group.authorize('tcp', ssh_port, ssh_port, cidr)
    except ec2.ResponseError, e:
        if e.code == 'InvalidPermission.Duplicate':
            print 'Security Group: %s already authorized' % group_name
        else:
            raise

    reservation = ec2.run_instances(ami,
                                    key_name=key_name,
                                    security_groups=[group_name],
                                    instance_type=instance_type,
                                    user_data=user_data,
                                    placement=azone)

    # Find the actual Instance object inside the Reservation object
    # returned by EC2.

    instance = reservation.instances[0]
    machinename = "shared--" + classcode + "--" + student_group
    # Add user tags to it

    instance.add_tag('student_ids', student_ids)
    instance.add_tag('classcode', classcode)
    instance.add_tag('Name', machinename)
    instance.add_tag('student_group', student_group)

    # The instance has been launched but it's not yet up and
    # running.  Let's wait for its state to change to 'running'.

    print 'waiting for instance'
    while instance.state != 'running':
        print '.'
        time.sleep(5)
        instance.update()

    create_status_alarm(instance.id)

    return 'Your instance has been created and is running at',
    instance.dns_name, '  Please use NX Viewer or remote desktop to connect.'


def list_shared_instances(ami='ami-',
                          instance_type='t1.micro',
                          key_name='instance_key',
                          key_extension='.pem',
                          key_dir='~/.ssh',
                          # key_dir='/home/infoadmin/keys',
                          group_name='vcl_lab',
                          ssh_port=22,
                          cidr='0.0.0.0/0',
                          tag='LBSC_670',
                          user_data=None,
                          cmd_shell=True,
                          login_user='ubuntu',
                          ssh_passwd=None,
                          username='',
                          classcode='',
                          azone='us-east-1c'):
    ec2 = boto.connect_ec2()
    reservations = ec2.get_all_instances(filters={
        'tag:student_ids': "*"+username+"*"})
    machines = {}
    for reservation in reservations:
        instance = reservation.instances[0]
        instance_tags = instance.tags
        if instance_tags[u'Name']:
            instance_name = instance_tags[u'Name']
        else:
            instance_name = "Lab machine"
        if instance.state != 'terminated':
            tmpinstance = str(instance.image_id)
            try:
                comp_lab_info = computerlab.objects.get(amazonami=tmpinstance)
                lab_auth_info = comp_lab_info.lab_auth_info
                connect_info = comp_lab_info.lab_connection_options
                coursecode = comp_lab_info.coursecode
            except Exception:
                comp_lab_info = {
                        'lab_auth_info': 'simple',
                        'lab_connection_options': 'test2'
                        }
                lab_auth_info = comp_lab_info['lab_auth_info']
                coursecode = 'none'
                connect_info = comp_lab_info['lab_connection_options']
            try:
                fetch_status = ec2.get_all_instance_status(
                        instance_ids=instance.id
                        )
                machine_status = \
                    fetch_status[0].system_status.details['reachability']
            except:
                machine_status = "stopped"
            machines[instance.id] = {
                'instance_name': instance_name,
                'coursecode': coursecode,
                'instance_type': instance.instance_type,
                'lab_auth_info': lab_auth_info,
                'instance_id': instance.id,
                'connect_info': connect_info,
                'instance_state': instance.state,
                'ami_id': instance.image_id,
                'machine_status': machine_status,
                'public_dns': instance.public_dns_name,
                'insert': str(instance_name)}

    return machines


@login_required(login_url='/accounts/login/')
def sandbox_page(request):
    myuser = request.user

    is_instructor = "no"
    check_instructor = faculty.objects.filter(directory_id=myuser.username)
    if check_instructor.count() > 0:
        is_instructor = "yes"

    action = 'Do Nothing'
    result = ''
    if 'iid' in request.POST:
        iid = request.POST['iid']
        if 'action' in request.POST:
            action = request.POST['action']
            if action == 'Start Server':
                result = start_instance(iid)
            if action == 'Stop Server':
                result = stop_instance(iid)
            if action == 'Create Server':
                iitype = str(request.POST['instance_type'])
                iid = request.POST['iid']
                credentials = request.POST['lab_auth_info']
                labname = request.POST['labname']
                monitor = request.POST['monitor']
                try:
                    result = create_sandbox_instance(
                            username=myuser.username,
                            ami=iid,
                            instance_type=iitype,
                            labname=labname,
                            is_instructor=is_instructor,
                            credentials=credentials,
                            monitor=monitor
                            )
                except:
                    iitype = 't2.micro'
                    result = create_sandbox_instance(
                            username=myuser.username,
                            ami=iid,
                            instance_type=iitype,
                            labname=labname,
                            is_instructor=is_instructor,
                            credentials=credentials,
                            monitor=monitor
                            )
            if action == 'Terminate Server':
                instructor.objects.filter(instance_id=iid).delete()
                result = terminate_instance(iid)
            if action == 'Download Connection File':
                public_dns = request.POST['public_dns']
                result = create_rdp_file(public_dns)

    error_msg = ''
    if result == "IntegrityError":
        error_msg = 'Only one server is allowed per course'

    list_of_machines = list_sandbox_instances(username=myuser.username)
    list_of_labs = sandbox.objects.all()

    # my_lab_info =
    #     computerlab.objects.get(amazonami=list_of_machines['ami_id'])
    return render_to_response('lab/sandbox.html',
                              {'list_of_machines': list_of_machines,
                               "is_instructor": is_instructor,
                               'error_msg': error_msg,
                               'myuser': myuser,
                               'action': action,
                               'list_of_labs': list_of_labs},
                              context_instance=RequestContext(request))
    # output =
    # 'Your instance is ready to use!  RDP or SSH to: ',instance.dns_name
    # return HttpResponseRedirect(reverse('lab.index', args=(output,)))


def create_sandbox_instance(ami='ami-ddb239b4',
                            instance_type='t1.micro',
                            # key_name='aws_vcl_key',
                            key_name='instance_key',
                            key_extension='.pem',
                            key_dir='~/.ssh',
                            # key_dir='/home/infoadmin/keys',
                            group_name='default',
                            ssh_port=22,
                            cidr='0.0.0.0/0',
                            tag='LBSC_670',
                            user_data=None,
                            cmd_shell=True,
                            login_user='ubuntu',
                            ssh_passwd=None,
                            username='',
                            classcode='iSchool',
                            instructor_id='',
                            credentials='',
                            monitor='yes',
                            is_instructor="no",
                            labname='',
                            azone='us-east-1c'):

    aws_conn = boto.ec2.connection.EC2Connection()
    # Create a connection to EC2 service.
    # You can pass credentials in to the connect_ec2 method explicitly
    # or you can use the default credentials in your ~/.boto config file
    # as we are doing here.
    ec2 = boto.connect_ec2()

    # Check to see if specified keypair already exists.
    # If we get an InvalidKeyPair.NotFound error back from EC2,
    # it means that it doesn't exist and we need to create it.
    try:
        key = ec2.get_all_key_pairs(keynames=[key_name])[0]
    except ec2.ResponseError, e:
        if e.code == 'InvalidKeyPair.NotFound':
            print 'Creating keypair: %s' % key_name
            # Create an SSH key to use when logging into instances.
            key = ec2.create_key_pair(key_name)

            # AWS will store the public key but the private key is
            # generated and returned and needs to be stored locally.
            # The save method will also chmod the file to protect
            # your private key.
            key.save(key_dir)
        else:
            raise

    # Check to see if specified security group already exists.
    # If we get an InvalidGroup.NotFound error back from EC2,
    # it means that it doesn't exist and we need to create it.
    try:
        group = ec2.get_all_security_groups(groupnames=[group_name])[0]
    except ec2.ResponseError, e:
        if e.code == 'InvalidGroup.NotFound':
            print 'Creating Security Group: %s' % group_name
            # Create a security group to control access to instance via SSH.
            group = ec2.create_security_group(group_name,
                                              'A group that allows SSH access')
        else:
            raise

    # Add a rule to the security group to authorize SSH traffic
    # on the specified port.
    try:
        group.authorize('tcp', ssh_port, ssh_port, cidr)
    except ec2.ResponseError, e:
        if e.code == 'InvalidPermission.Duplicate':
            print 'Security Group: %s already authorized' % group_name
        else:
            raise

        # find the volume for the user and class in question
        # volumes = ec2.get_all_volumes(filters=
        # {'tag-value': username, 'tag-value':classcode})
        # Attach the volume to the server
        # result = volumes.attach(instance, '/dev/sdf')
        # define user data to mount the volume
        # Now start up the instance.  The run_instances method
        # has many, many parameters but these are all we need
        # for now.
    reservation = ec2.run_instances(ami,
                                    key_name=key_name,
                                    security_groups=[group_name],
                                    instance_type=instance_type,
                                    user_data=user_data,
                                    placement=azone)

    # Find the actual Instance object inside the Reservation object
    # returned by EC2.

    instance = reservation.instances[0]
    machinename = "sandbox: " + labname + "--" + username
    sandbox_user = "sandbox_user:"+username
    instance.add_tag('sandbox_user', sandbox_user)
    instance.add_tag('Name', machinename)

    # The instance has been launched but it's not yet up and
    # running.  Let's wait for its state to change to 'running'.

    print 'waiting for instance'
    while instance.state != 'running':
        print '.'
        time.sleep(5)
        instance.update()

    if is_instructor == "no":
        create_status_alarm(instance.id)
    if is_instructor == "yes":
        if monitor == "yes":
            create_status_alarm(instance.id)

    return 'Your instance has been created and is running at',
    instance.dns_name,
    '  Please use NX Viewer or remote desktop to connect.'


def list_sandbox_instances(ami='ami-',
                           instance_type='t1.micro',
                           key_name='instance_key',
                           key_extension='.pem',
                           key_dir='~/.ssh',
                           # key_dir='/home/infoadmin/keys',
                           group_name='vcl_lab',
                           ssh_port=22,
                           cidr='0.0.0.0/0',
                           tag='LBSC_670',
                           user_data=None,
                           cmd_shell=True,
                           login_user='ubuntu',
                           ssh_passwd=None,
                           username='',
                           classcode='',
                           azone='us-east-1c'):
    ec2 = boto.connect_ec2()
    reservations = ec2.get_all_instances(filters={
        'tag:sandbox_user': "*"+username+"*"}
        )
    machines = {}
    for reservation in reservations:
        instance = reservation.instances[0]
        instance_tags = instance.tags
        if instance_tags[u'Name']:
            instance_name = instance_tags[u'Name']
        else:
            instance_name = "Lab machine"
        if instance.state != 'terminated':
            tmpinstance = str(instance.image_id)
            try:
                comp_lab_info = sandbox.objects.get(amazonami=tmpinstance)
                lab_auth_info = comp_lab_info.lab_auth_info
                labname = comp_lab_info.labname
            except Exception:
                comp_lab_info = {'lab_auth_info': 'simple',
                                 'lab_connection_options': 'test2'
                                 }
                lab_auth_info = comp_lab_info['lab_auth_info']
                labname = 'none'
            try:
                fetch_status = ec2.get_all_instance_status(
                        instance_ids=instance.id
                        )
                machine_status = fetch_status[0].system_status.details
                ['reachability']
            except:
                machine_status = "stopped"

            machines[instance.id] = {
                    'instance_name': instance_name,
                    'labname': labname,
                    'instance_type': instance.instance_type,
                    'lab_auth_info': lab_auth_info,
                    'instance_id': instance.id,
                    'instance_state': instance.state,
                    'ami_id': instance.image_id,
                    'machine_status': machine_status,
                    'public_dns': instance.public_dns_name,
                    'insert': str(instance_name)
                    }

    return machines
