oozie_short_version="#{node[:oozie][:version]}"

   # Put impersonation stuff in oozie-site.xml
   ruby_block "Alter_oozie-site.xml" do
     block do
          file  = Chef::Util::FileEdit.new("/opt/mapr/oozie/oozie-#{oozie_short_version}/conf/oozie-site.xml")

          file.search_file_replace_line("</configuration>","<property>
        <name>oozie.service.ProxyUserService.proxyuser.mapr.hosts</name>
        <value>*</value>
</property>

<property>
        <name>oozie.service.ProxyUserService.proxyuser.mapr.groups</name>
        <value>*</value>
</property>
</configuration>")
        file.write_file
      end
    end

