bash "jdk_installation" do
  action :run
  cwd "/tmp"
  code <<-EOH
  wget --no-cookies \
--header "Cookie: oraclelicense=accept-securebackup-cookie" \
http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.rpm \
--no-check-certificate -O jdk-8u31-linux-x64.rpm
rpm -ivh jdk-8u31-linux-x64.rpm
  EOH
  only_if "if ! rpm -qa | grep -qw jdk1.8.0_31; then exit 0;else exit 1;fi"
end
