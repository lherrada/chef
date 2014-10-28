#
# Cookbook Name:: basic
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get-update" do
  command "sudo apt-get update"
  ignore_failure false 
  action :run
end

#Adding user
user node[:basic][:username1]  do
 supports :manage_home => true
 comment "User to run commands"
 home node[:basic][:home1] 
 shell "/bin/bash"
 password "$1$pk8UU3y9$y8qpOwe4V5p/ohV/8d3Nt1"
end

#template '/home/sherrada/.ssh/authorized_keys' do
# source 'authorized_keys.erb'
#end
#

#Adding SSH key

directory "#{node[:basic][:home1]}/.ssh" do
 owner node[:basic][:username1]
 group node[:basic][:username1]
 mode '700'
 action :create
end
 
file "#{node[:basic][:home1]}/.ssh/authorized_keys" do
 owner node[:basic][:username1]
 group node[:basic][:username1]
 mode '600'
 content 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxl2l7LVJ8Jg+Saknay2pSdSW2h4Oaz20IdXSg+dGff877CLH9E4WxKSqEWE1Iro8gR14aRJbYMm1ds9du8qWaJKwQGIO8X5+N4XjsMzmFYuMiLiNM97DOUJqEWSRc7fkJRPEKbgP2pZ3IwNXAI+6FLRrwvc1Cq/FkM82ou9HrzupPA4wV9RgNBacmSsEnOku5mOI70YoCYjk1T4Lif3ef39UH7uGy1ktHdJFtAL1vn3kZFKOtQGflhhXNyd3StcWcRsj30So2y92HpTKhKLzqQwtgWnIm8lsVE6bNgQ6NwTPmhhCX3t01BH6F0eWxDByAIa6ZbQNG9+hmmT0T+2U3 lherrada@Luiss-MacBook-Pro.local'
 action :create
end

template "/etc/sudoers" do
 source "sudoers.erb"
 mode '0440'
 owner 'root'
 group 'root'
 variables({
     :sudoers_users => node[:authorization][:sudo][:users]
 })
end

#ifconfig "name" do
#  device "eth0"
#  action :disable
#  target "10.0.2.15"
#end

node.default["source"]='bash_profile.erb'
template "#{node[:basic][:home1]}/.bash_profile" do
 owner node[:basic][:username1]
 group node[:basic][:username1]
 mode '644'
 #source "#{node[:source]}" 
 source node[:source] 
end 


#Disabling iptables
service 'iptables' do
 action :stop
end

#Adding vim package
package "vim" do
 action :install
end

package "git" do
 action :install
end
