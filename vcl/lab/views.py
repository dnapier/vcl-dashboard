from django.shortcuts import render, render_to_response, RequestContext

from django.shortcuts import render_to_response, get_object_or_404
from lab.models import computerlab
from django.template import Context, loader, RequestContext
from django.http import HttpResponseRedirect, HttpResponse
from django.core.urlresolvers import reverse
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import logout_then_login
from django.contrib.auth import logout
from django.contrib.auth.models import User
import os
import time
import boto
import boto.manage.cmdshell
import boto.manage.server



# Create your views here.
def home(request):
    return render_to_response("signup.html",
                              locals(),
                              context_instance=RequestContext(request))

def logout_view(request):
    logout(request)
   #return HttpResponseRedirect('registration/logout.html')
    return render_to_response('registration/logout.html',locals(),context_instance=RequestContext(request))
   

@login_required(login_url='/accounts/login/')
def index(request):
    myuser = request.user
    action = 'Do Nothing'
    if 'iid' in request.POST:
        iid = request.POST['iid']
	if 'action' in request.POST:
            action = request.POST['action']
            if action == 'Start Server':
                result = start_instance(iid)
            if action == 'Stop Server':
                result = stop_instance(iid)
            if action == 'Create Server':
        	iitype = request.POST['instance_type']
		iid = request.POST['iid']
		coursecode = request.POST['coursecode']
		result = create_instance(username=myuser.username, ami=iid, instance_type=iitype, classcode=coursecode)
            if action == 'Terminate Server':
                result = terminate_instance(iid)
            if action == 'Download Connection File':
		public_dns = request.POST['public_dns']
		result = create_rdp_file(public_dns)
    list_of_machines = list_instances(username=myuser.username)
    list_of_labs = computerlab.objects.all()
    #my_lab_info = computerlab.objects.get(amazonami=list_of_machines['ami_id'])
    return render_to_response('lab/index.html', {'list_of_machines':list_of_machines, 'myuser':myuser, 'action': action, 'list_of_labs':list_of_labs}, context_instance=RequestContext(request))
     #output =  'Your instance is ready to use!  RDP or SSH to: ',instance.dns_name
    #return HttpResponseRedirect(reverse('lab.index', args=(output,)))

     


###################################################

#code from vcl


def create_instance(ami='ami-ddb239b4',
                    instance_type='t1.micro',
                    key_name='aws_vcl_key',
                    key_extension='.pem',
                    key_dir='~/.ssh',
                    group_name='default',
                    ssh_port=22,
                    cidr='0.0.0.0/0',
                    tag='LBSC_670',
                    user_data=None,
                    cmd_shell=True,
                    login_user='ubuntu',
                    ssh_passwd=None,
                    username = '',
                    classcode='iSchool',
                    azone = 'us-east-1c'):
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
    user_data ="""#!/bin/bash
set -e -x
export DEBIAN_FRONTEND=noninteractive
apt-get --yes remove --force-yes freenx-server
apt-get install --force-yes freenx-server
"""
    #user_data = "apt-get install -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold'  -f -q -y freenx-server"

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

	#find the volume for the user and class in question
	#volumes = ec2.get_all_volumes(filters={'tag-value': username, 'tag-value':classcode})
	#Attach the volume to the server
	#result = volumes.attach(instance, '/dev/sdf')
	#define user data to mount the volume
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
    machinename = classcode + "--" + username
    #Add user tags to it
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
    return 'Your instance has been created and is running at', instance.dns_name, '  Please use NX Viewer or remote desktop to connect.'

def create_rdp_file(request):
	from django.http import HttpResponse
	#import StringIO	
	import csv
	public_dns=request.GET['public_dns']
	import cStringIO as StringIO
	#response = HttpResponse(tmpfile, content_type="application/x-rdp")
	#response['Content-Disposition'] = 'attachment; filename=connect.rdp'	
	#writer = csv.writer(response)
	#myfile = StringIO.StringIO(response)
	tmpfile = """ screen mode id:i:1
desktopwidth:i:1400
desktopheight:i:875
session bpp:i:16
auto connect:i:1
compression:i:1
keyboardhook:i:2
audiomode:i:2
redirectdrives:i:0
redirectprinters:i:0
redirectcomports:i:0
redirectsmartcards:i:0
displayconnectionbar:i:1
username:s:
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

	#tmpfile = tmpfile+"full address:s:"+public_dns
	#writer.writerow([tmpfile])
        response = HttpResponse(tmpfile, content_type="application/x-rdp")
        response['Content-Disposition'] = 'attachment; filename=connect.rdp'
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
    iid = [instance.id]
    instance_state = ec2.terminate_instances(iid)
    while instance.state != 'stopped':
        print '.'
        time.sleep(5)
        instance.update()
		
def list_instances(ami='ami-',
                   instance_type='t1.micro',
                   key_name='',
                   key_extension='.pem',
                   key_dir='~/.ssh',
                   group_name='vcl_lab',
                   ssh_port=22,
                   cidr='0.0.0.0/0',
                   tag='LBSC_670',
                   user_data=None,
                   cmd_shell=True,
                   login_user='ubuntu',
                   ssh_passwd=None,
                   username = '',
                   classcode='',
                   azone = 'us-east-1c'):         
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
				tmpinstance = instance.image_id
				#comp_lab_info = {'lab_auth_info':'Sorry, I could not find any authentication information', 'lab_connection_options':'Sorry, I could not find connection options!'}
				try:
					comp_lab_info = computerlab.objects.get(amazonami=tmpinstance)
                                	lab_auth_info = comp_lab_info.lab_auth_info
                                	connect_info = comp_lab_info.lab_connection_options  
					coursecode = comp_lab_info.coursecode
				except Exception:
					comp_lab_info = {'lab_auth_info':'simple', 'lab_connection_options':'test2'}
					lab_auth_info = comp_lab_info['lab_auth_info']
					coursecode = 'none'
					connect_info = comp_lab_info['lab_connection_options']
				machines[instance.id] = {'instance_name': instance_name,'coursecode': coursecode, 'instance_type': instance.instance_type, 'lab_auth_info': lab_auth_info, 'instance_id': instance.id, 'connect_info': connect_info ,'instance_state': instance.state, 'ami_id': instance.image_id, 'public_dns': instance.public_dns_name}

		return machines
