#
# Cookbook Name:: mapr_oozie
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Set some variables for later...

#Identify a Resource Manager server for yarn-site.xml
rm_server="#{node[:mapr][:rm][0]}"

# Identify installation versions for oozie, based on oozie version in attributes
oozie_short_version="#{node[:oozie][:version]}"
oozie_install_version=`yum list --showduplicates mapr-oozie|grep "#{oozie_short_version}"|awk '{print $2}'|tr -d '\n'`
hadoop_version=`ls /opt/mapr/hadoop|grep hadoop-2|tr -d '\n'`

print "\n\n\noozie_short_version = #{oozie_short_version}\n\n"

print "\n\n\noozie_install_version = \"#{oozie_install_version}\"\n\n\n"

# Install Oozie from attributes
 if node['fqdn'] == "#{node[:mapr][:oozie]}" 
    print "\nWill install Oozie Services on node: #{node['fqdn']}\n"

    include_recipe "mapr_oozie::install_oozie"
    include_recipe "mapr_oozie::edit_yarn-site"
    include_recipe "mapr_oozie::edit_core-site"
    include_recipe "mapr_oozie::edit_oozie-site"
    include_recipe "mapr_oozie::install_oozie_ui"
    include_recipe "mapr_oozie::copy_example_data"

    bash  'Restart_warden_and_ooozie' do
      code <<-EOH
          service mapr-oozie stop
          service mapr-warden restart
      EOH
   end
end

# Alter core-site.xml for Resource Managers
node["mapr"]["rm"].each do |rm|
  if node['fqdn'] == "#{rm}"
    print "\nWill alter core-site.xml on Resource Manager: #{node['fqdn']}\n"

    include_recipe "mapr_oozie::edit_core-site"

    bash 'Restart_warden_for_core-site_changes' do 
      code <<-EOH
        service mapr-warden restart
      EOH
    end

  end
end
