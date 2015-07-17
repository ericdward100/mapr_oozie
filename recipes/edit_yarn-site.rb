#Identify a Resource Manager server for yarn-site.xml
rm_server="#{node[:mapr][:rm][0]}"

oozie_short_version="#{node[:oozie][:version]}"

hadoop_version=`ls /opt/mapr/hadoop|grep hadoop-2|tr -d '\n'`

    # Copy yarn-site.xml from one of the Resource Managers
    bash  'copy_yarn-site.xml' do
      code <<-EOH
          scp #{rm_server}:/opt/mapr/hadoop/#{hadoop_version}/etc/hadoop/yarn-site.xml /opt/mapr/oozie/oozie-#{oozie_short_version}/conf/hadoop-conf/
      EOH
   end

