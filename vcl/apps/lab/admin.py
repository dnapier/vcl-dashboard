from .models import computerlab,sandbox,faculty
from django.contrib import admin
from django.contrib.auth.models import User

class computerlabAdmin(admin.ModelAdmin):
	fields = ['labname', 'labdescription', 'lab_auth_info', 'lab_connection_options', 'group_name', 'instance_type', 'coursename', 'coursecode', 'coursesemester', 'courseinstructor','courseinstructor2','courseinstructor3','instructor_id','instructor2_id','instructor3_id', 'amazonami', 'date_created']


class computerlabSandbox(admin.ModelAdmin):
        fields = ['labname', 'labdescription', 'lab_auth_info', 'instance_type','instance_type_desc','softwares' ,'amazonami', 'date_created']

class computerlabFaculty(admin.ModelAdmin):
        fields = ['directory_id']

admin.site.register(computerlab, computerlabAdmin)
admin.site.register(sandbox, computerlabSandbox)
admin.site.register(faculty, computerlabFaculty)
