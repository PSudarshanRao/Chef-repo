#
# Cookbook Name:: CDH5
# Recipe:: default
#
# Copyright 2015, CLOUDWICK TECHNOLOGIES
#
# All rights reserved - Do Not Redistribute
#
template "/etc/yum.repos.d/cloudera-cdh5.repo" do
  source "cloudera-cdh5.repo.erb"
  mode "0644"
  owner "root"
  group "root"
end
node['CDH5']['daemon_role'].each do |daemon|
  package daemon do
    action :install
  end
end
