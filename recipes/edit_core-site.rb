hadoop_version=`ls /opt/mapr/hadoop|grep hadoop-2|tr -d '\n'`

   # Put impersonation stuff in core-site.xml
   ruby_block "Alter_core-site.xml" do
     block do
          file  = Chef::Util::FileEdit.new("/opt/mapr/hadoop/#{hadoop_version}/etc/hadoop/core-site.xml")

          file.search_file_replace_line("</configuration>","<property>
  <name>hadoop.proxyuser.mapr.hosts</name>
  <value>*</value>
</property>
<property>
  <name>hadoop.proxyuser.mapr.groups</name>
  <value>*</value>
</property>

</configuration>")
        file.write_file


      end
    end

