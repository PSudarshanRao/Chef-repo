if node['CDH5']['daemon_role'].include? 'hadoop-hdfs-namenode'
  execute "format-namenode" do
    command "sudo -u hdfs hdfs namenode -format"
    not_if "test -d #{node['CDH5']['hdfs-local-dir']}/name/current"
  end
end

node['CDH5']['daemon_role'].each do |daemon|
  service daemon do
    action [:enable, :start]
    supports :restart => true, :stop => true
  end
end
