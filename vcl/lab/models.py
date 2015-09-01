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
	amazonami = models.CharField(max_length=100)
	date_created = models.DateTimeField('date published')
	lab_auth_info = models.CharField(max_length=100)
	lab_connection_options = models.CharField(max_length=100)	
	group_name = models.CharField(max_length=100)
	instance_type = models.CharField(max_length=20)
	def __unicode__(self):
		return self.labname
