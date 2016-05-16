from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    url(r'^$', 'vcl.apps.lab.views.index', name='index'),
    url(r'^home/', 'vcl.apps.lab.views.home', name='home'),
    url(r'^downloadrdp/$','vcl.apps.lab.views.create_rdp_file'),
    url(r'^instructor/downloadrdp/$','vcl.apps.lab.views.create_rdp_file'),
    url(r'^instructor/', 'vcl.apps.lab.views.tutor', name='tutor'),
    url(r'^groups/downloadrdp/$','vcl.apps.lab.views.create_rdp_file'),
    url(r'^groups/', 'vcl.apps.lab.views.groups', name='groups'),	
    url(r'^sandbox/downloadrdp/$','vcl.apps.lab.views.create_rdp_file'),
    url(r'^sandbox/', 'vcl.apps.lab.views.sandbox_page', name='sandbox_page'),
#    url(r'^logout/', 'vcl.apps.lab.views.logout_view'),
#django_cas links
	url(r'^accounts/login/$', 'cas.views.login'),
	url(r'^accounts/logout/', 'cas.views.logout'),
#django_cas ends
#     url(r'^blog/', include('blog.urls')),
   url(r'^accounts/', include('registration.backends.default.urls')),

    url(r'^admin/', include(admin.site.urls)),
)
