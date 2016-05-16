# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='computerlab',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('labname', models.CharField(max_length=100)),
                ('labdescription', models.CharField(max_length=100)),
                ('coursename', models.CharField(max_length=100)),
                ('coursecode', models.CharField(max_length=100)),
                ('coursesemester', models.CharField(max_length=100)),
                ('courseinstructor', models.CharField(max_length=100)),
                ('instructor_id', models.CharField(max_length=100)),
                ('amazonami', models.CharField(max_length=100)),
                ('date_created', models.DateTimeField(verbose_name=b'date published')),
                ('lab_auth_info', models.CharField(max_length=100)),
                ('lab_connection_options', models.CharField(max_length=100)),
                ('group_name', models.CharField(max_length=100)),
                ('instance_type', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='instructor',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('instance_id', models.CharField(max_length=50)),
                ('instructor_id', models.CharField(max_length=50)),
                ('course_id', models.CharField(max_length=50)),
                ('student_id', models.CharField(max_length=50)),
                ('student_name', models.CharField(max_length=50)),
            ],
        ),
    ]
