#
# Cookbook Name:: kerberos
# Recipe:: default
#
# Copyright 2015, CLOUDWICK TECHNOLOGIES
#
# All rights reserved - Do Not Redistribute
#
package "krb5-workstation" do
  action :install
end
package "krb5-server" do
  action :install
  only_if {node['kerberos']['kdc_server'] == node['fqdn']}
end
package "krb5-libs" do
  action :install
end
template "/var/kerberos/krb5kdc/kdc.conf" do
  source "kdc.conf.erb"
  mode "0644"
  owner "root"
  group "root"
  variables ({
  :realm => node['kerberos']['realm_name']
  })
  only_if {node['kerberos']['kdc_server'] == node['fqdn']}
# notifies :restart, "service[krb5kdc]"
end
template "/etc/krb5.conf" do
  source 'krb5.conf.erb'
  mode "0644"
  owner "root"
  group "root"
  variables ({
  :realm => node['kerberos']['realm_name'],
  :kdc => node['kerberos']['kdc_server']
  })
notifies :restart, "service[kadmin]"
end
service "krb5kdc" do
  action [:enable, :start]
  supports :restart => true, :stop => true
  only_if {node['kerberos']['kdc_server'] == node['fqdn']}
end
service "kadmin" do
  action [:enable, :start]
  supports :restart => true, :stop => true
  only_if {node['kerberos']['kdc_server'] == node['fqdn']}
end
