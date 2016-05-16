from .models import computerlab
from django.contrib import admin
from django.contrib.auth.models import User

class computerlabAdmin(admin.ModelAdmin):
	fields = ['labname', 'labdescription', 'lab_auth_info', 'lab_connection_options', 'group_name', 'instance_type', 'coursename', 'coursecode', 'coursesemester', 'courseinstructor','instructor_id', 'amazonami', 'date_created']

admin.site.register(computerlab, computerlabAdmin)
