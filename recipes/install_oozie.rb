hadoop_version=`ls /opt/mapr/hadoop|grep hadoop-2|tr -d '\n'`
oozie_short_version="#{node[:oozie][:version]}"
oozie_install_version=`yum list --showduplicates mapr-oozie|grep "#{oozie_short_version}"|awk '{print $2}'|tr -d '\n'`


    bash 'install_mapr-oozie' do
      code <<-EOH
        yum -y install mapr-oozie-#{oozie_install_version}
        #  REMOVE THE OFFENDING JARS FOR KNOWN ISSUE IN 4.1.0
        if [ -e /opt/mapr/hadoop/#{hadoop_version}/share/hadoop/httpfs/tomcat/webapps/webhdfs/WEB-INF/lib/maprfs-4.1.0-mapr.jar ]
        then
          rm -rf /opt/mapr/hadoop/#{hadoop_version}/share/hadoop/httpfs/tomcat/webapps/webhdfs/WEB-INF/lib/maprfs-4.1.0-mapr.jar
        fi
        if [ -e /opt/mapr/hadoop/#{hadoop_version}/share/hadoop/tools/lib/maprfs-4.1.0-mapr.jar ]
        then
          rm -rf /opt/mapr/hadoop/#{hadoop_version}/share/hadoop/tools/lib/maprfs-4.1.0-mapr.jar
        fi
      EOH
    end
