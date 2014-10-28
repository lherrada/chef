#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "redis-server" do
 action :install
end

template "/etc/redis/redis.conf" do
 source "redis.erb"
end

service "redis-server" do
 action [:restart, :enable]
end
