from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    url(r'^$', 'lab.views.index', name='index'),
    url(r'^home/', 'lab.views.home', name='home'),
    url(r'^downloadrdp/$','lab.views.create_rdp_file'),
    url(r'^logout/', 'lab.views.logout_view'),
    # url(r'^blog/', include('blog.urls')),
   url(r'^accounts/', include('registration.backends.default.urls')),

    url(r'^admin/', include(admin.site.urls)),
)
