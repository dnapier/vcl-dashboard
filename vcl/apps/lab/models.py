from django.db import models
import datetime
from django.utils import timezone
from django.contrib.auth.models import User

# Create your models here.
class computerlab(models.Model):
	labname = models.CharField(max_length=100)
	labdescription = models.CharField(max_length=100)
	coursename = models.CharField(max_length=100)
	coursecode = models.CharField(max_length=100)
	coursesemester = models.CharField(max_length=100)
	courseinstructor = models.CharField(max_length=100)
	courseinstructor2 = models.CharField(max_length=100)
	courseinstructor3 = models.CharField(max_length=100)
	instructor_id = models.CharField(max_length=100)
	instructor2_id = models.CharField(max_length=100)
	instructor3_id = models.CharField(max_length=100)
	amazonami = models.CharField(max_length=100)
	date_created = models.DateTimeField('date published')
	lab_auth_info = models.CharField(max_length=100)
	lab_connection_options = models.CharField(max_length=100)	
	group_name = models.CharField(max_length=100)
	instance_type = models.CharField(max_length=20)
	def __unicode__(self):
		return self.labname

class sandbox(models.Model):
        labname = models.CharField(max_length=100)
        labdescription = models.CharField(max_length=100)
        amazonami = models.CharField(max_length=100)
        date_created = models.DateTimeField('date published')
        lab_auth_info = models.CharField(max_length=100)
        instance_type = models.CharField(max_length=20)
	instance_type_desc = models.CharField(max_length=50)
	softwares = models.CharField(max_length=500)
        def __unicode__(self):
                return self.labname

class faculty(models.Model):
        directory_id = models.CharField(max_length=30)
        def __unicode__(self):
                return self.directory_id

class instructor(models.Model):
    instance_id = models.CharField(max_length=50)
    instructor_id = models.CharField(max_length=50)
    course_id = models.CharField(max_length=50)
    student_id = models.CharField(max_length=50)	
    student_name = models.CharField(max_length=50)
    credentials = models.CharField(max_length=100)   	

class groups(models.Model):
    group_name = models.CharField(max_length=50)
    course = models.CharField(max_length=50)
    instructor = models.CharField(max_length=50)
    group_size = models.CharField(max_length=50)

class students_groups(models.Model):
    student_id = models.CharField(max_length=50)
    group_id = models.CharField(max_length=50)
    

    def __str__(self):              # __unicode__ on Python 2
        return self.instructor_id

