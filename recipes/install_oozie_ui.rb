oozie_short_version="#{node[:oozie][:version]}"

   # Install the Oozie UI
   bash 'Install Oozie GUI' do
      code <<-EOH
          sleep 120

          service mapr-oozie stop
          wget -P ~ dev.sencha.com/deploy/ext-2.2.zip
          /opt/mapr/oozie/oozie-#{oozie_short_version}/bin/oozie-setup.sh prepare-war -extjs ~/ext-2.2.zip
          service mapr-oozie start
      EOH
    end

