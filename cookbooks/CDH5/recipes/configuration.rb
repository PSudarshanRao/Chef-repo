directory "/dfs" do
  mode "0775"
  owner "hdfs"
  group "hadoop"
end
directory "/mapred" do
  mode "0775"
  owner "mapred"
  group "hadoop"
end
template"/etc/hadoop/conf.empty/core-site.xml" do
    source 'configuration.erb'
    mode '0644'
    owner 'root'
    group 'root'
    variables ({
    :properties => node['CDH5']['core']
    })
    node['CDH5']['daemon_role'].each do |daemon|
      notifies :restart, "service[#{daemon}]"
    end
end
template"/etc/hadoop/conf.empty/hdfs-site.xml" do
    source 'configuration.erb'
    mode '0644'
    owner 'root'
    group 'root'
    variables ({
    :properties => node['CDH5']['hdfs']
    })
    node['CDH5']['daemon_role'].each do |daemon|
      notifies :restart, "service[#{daemon}]"
    end
end
template"/etc/hadoop/conf.empty/mapred-site.xml" do
    source 'configuration.erb'
    mode '0644'
    owner 'root'
    group 'root'
    variables ({
    :properties => node['CDH5']['mapred']
    })
    node['CDH5']['daemon_role'].each do |daemon|
      notifies :restart, "service[#{daemon}]"
    end
end
template"/etc/hadoop/conf.empty/yarn-site.xml" do
    source 'configuration.erb'
    mode '0644'
    owner 'root'
    group 'root'
    variables ({
    :properties => node['CDH5']['yarn']
    })
    node['CDH5']['daemon_role'].each do |daemon|
      notifies :restart, "service[#{daemon}]"
    end
end

