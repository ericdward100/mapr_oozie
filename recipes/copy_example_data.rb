oozie_short_version="#{node[:oozie][:version]}"

    bash 'Copy Example stuff to maprfs' do
       code <<-EOH
          tar xvzf /opt/mapr/oozie/oozie-#{oozie_short_version}/oozie-examples.tar.gz -C /opt/mapr/oozie/oozie-#{oozie_short_version}/
          hadoop fs -put /opt/mapr/oozie/oozie-#{oozie_short_version}/examples maprfs:///oozie/
          hadoop fs -put /opt/mapr/oozie/oozie-#{oozie_short_version}/examples maprfs:///user/mapr/
          hadoop fs -put /opt/mapr/oozie/oozie-#{oozie_short_version}/examples/input-data maprfs:///user/mapr
          hadoop fs -chmod -R 777 maprfs:///oozie/examples
          hadoop fs -chmod -R 777 maprfs:///user/mapr/examples
          echo export OOZIE_URL="http://localhost:11000/oozie" >>/etc/profile
      EOH
    end

