#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

#package_name='httpd'
#service_name='httpd'
#document_root='/var/www/html'

if platform?("debian","ubuntu")
 package_name = 'apache2'
 service_name = 'apache2'
 document_root = '/var/www'
end

if platform?("centos","redhat","fedora","suse")
 package_name = 'httpd'
 service_name = 'httpd'
 document_root = '/var/www/html'
end

#package "apache2" do
#  case node[:platform]
#  when "centos","redhat","fedora","suse"
#    package_name "httpd"
#  when "debian","ubuntu"
#    package_name "apache2"
#  when "arch"
#    package_name "apache"
#  end
#  action :install
#end

#service "httpd" do
#  case node[:platform]
#  when "centos","redhat","fedora","suse"
 #   service_name "httpd"
#  when "debian","ubuntu"
#    service_name "apache2"
#  end
#  action [:start, :enable]
#end

directory document_root do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


package package_name do
 action :install
end 

package "libapache2-mod-wsgi" do
  action :install 
end
 
package "python-pip" do
  action :install 
end

package "curl" do
 action :install
end

package "python-django" do
 action :remove
end



#template '/var/www/html/index.html' do
template "#{document_root}/index.html" do
  source 'index.html.erb'
end

template "/etc/apache2/sites-available/django" do
 owner 'root'
 group 'root'
 mode '0644'
 source 'django_apache.erb'
end

template "/etc/apache2/envvars" do
 owner 'root'
 group 'root'
 mode '0644'
 source 'envvars.erb'
end
 
execute "wsgi_module" do
 command "sudo /usr/sbin/a2enmod wsgi" 
 ignore_failure false
 action :run
end

execute "django_site" do
 command "sudo /usr/sbin/a2ensite django" 
 ignore_failure false
 action :run
end

execute "pip_redis" do
 command "sudo pip install redis"
 ignore_failure false
 action :run
end

execute "pip_django" do
 command "sudo pip install Django"
 ignore_failure false
 action :run
end

execute "django_system_app" do
 cwd document_root 
 command "curl https://raw.githubusercontent.com/lherrada/downloads/master/system.tar.gz|tar xvfz -"
 ignore_failure false
 action :run
end

service service_name do
  action [:start, :enable]
end
