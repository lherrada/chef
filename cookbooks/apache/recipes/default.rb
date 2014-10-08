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
 document_root = '/var/www/'
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

package package_name do
 action :install
end 

service service_name do
  action [:start, :enable]
end

#template '/var/www/html/index.html' do
template "#{document_root}/index.html" do
  source 'index.html.erb'
end
