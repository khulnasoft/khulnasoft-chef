# frozen_string_literal: true

# Cookbook Name:: opendistro
# Recipe:: kibana
# Author:: Khulnasoft <info@khulnasoft.com>

# Install the Kibana package

case node['platform']
when 'debian', 'ubuntu'
  apt_package 'opendistroforelasticsearch-kibana' do
    version (node['odfe']['patch_version']).to_s
  end
when 'redhat', 'centos', 'amazon', 'fedora', 'oracle'
  if node['platform_version'] >= '8'
    dnf_package 'opendistroforelasticsearch-kibana' do
      version (node['odfe']['patch_version']).to_s
    end
  else
    yum_package 'opendistroforelasticsearch-kibana' do
      version (node['odfe']['patch_version']).to_s
    end
  end
when 'opensuseleap', 'suse'
  zypper_package 'opendistroforelasticsearch-kibana' do
    version (node['odfe']['patch_version']).to_s
  end
else
  raise 'Currently platforn not supported yet. Feel free to open an issue on https://www.github.com/khulnasoft/khulnasoft-chef if you consider that support for a specific OS should be added'
end

# Create Kibana configuration file

template "#{node['kibana']['config_path']}/kibana.yml" do
  source 'kibana.yml.erb'
  owner 'root'
  group 'kibana'
  variables({
              server_port: (node['kibana']['yml']['server']['port']).to_s,
              server_host: (node['kibana']['yml']['server']['host']).to_s,
              elasticsearch_hosts: node['kibana']['yml']['elasticsearch']['hosts']
            })
  mode 0755
end

# Update the optimize and plugins directories permissions

execute "Change #{node['kibana']['package_path']}/optimize owner" do
  command "sudo chown -R kibana:kibana #{node['kibana']['package_path']}/optimize"
end

execute "Change #{node['kibana']['package_path']}/plugins owner" do
  command "sudo chown -R kibana:kibana #{node['kibana']['package_path']}/plugins"
end

# Install the Khulnasoft Kibana plugin

execute 'Install Khulnasoft Kibana plugin' do
  command "sudo -u kibana #{node['kibana']['package_path']}/bin/kibana-plugin install https://packages.wazuh.com/#{node['khulnasoft']['major_version']}/ui/kibana/khulnasoft_kibana-#{node['khulnasoft']['kibana_plugin_version']}-1.zip"
  not_if {
    Dir.exist?("#{node['kibana']['plugins_path']}/khulnasoft")
  }
end

# Create Khulnasoft-Kibana plugin configuration file

execute 'Create khulnasoft.yml parent folders' do
  command "sudo -u kibana mkdir -p #{node['kibana']['package_path']}/optimize/khulnasoft && \
           sudo -u kibana mkdir -p #{node['kibana']['package_path']}/optimize/khulnasoft/config"
end

template "#{node['kibana']['optimize_path']}/khulnasoft/config/khulnasoft.yml" do
  source 'khulnasoft.yml.erb'
  owner 'kibana'
  group 'kibana'
  mode '0600'
  action :create
  variables({
              api_credentials: node['kibana']['khulnasoft_api_credentials']
            })
  only_if {
    Dir.exist?("#{node['kibana']['optimize_path']}/khulnasoft/config")
  }
end

# Certificates placement

directory (node['kibana']['certs_path']).to_s do
  action :create
end

ruby_block 'Copy certificate files' do
  block do
    if File.exist?((node['elastic']['certs_path']).to_s)
      IO.copy_stream("#{node['elastic']['certs_path']}/kibana_http.pem", "#{node['kibana']['certs_path']}/kibana.pem")
      IO.copy_stream("#{node['elastic']['certs_path']}/kibana_http.key", "#{node['kibana']['certs_path']}/kibana.key")
      IO.copy_stream("#{node['elastic']['certs_path']}/root-ca.pem", "#{node['kibana']['certs_path']}/root-ca.pem")
    else
      Chef::Log.fatal("Please copy the following files where Elasticsearch is installed to
        #{node['kibana']['certs_path']}:
          - #{node['elastic']['certs_path']}/kibana_http.key (rename as kibana.key)
          - #{node['elastic']['certs_path']}/kibana_http.pem (rename as kibana.pem)
          - #{node['elastic']['certs_path']}/root-ca.pem
        Then run as sudo:
          - systemctl daemon-reload
          - systemctl enable kibana
          - systemctl start kibana")
    end
  end
  action :run
end

# Link Kibana’s socket to privileged port 443

execute 'Link kibana socket to 443 port' do
  command "setcap 'cap_net_bind_service=+ep' #{node['kibana']['package_path']}/node/bin/node"
end

# Enable and start the Kibana service

service 'kibana' do
  supports start: true, stop: true, restart: true, reload: true
  action %i[enable start]
  only_if do
    File.exist?("#{node['kibana']['certs_path']}/kibana.pem") &&
      File.exist?("#{node['kibana']['certs_path']}/kibana.key") &&
      File.exist?("#{node['kibana']['certs_path']}/root-ca.pem")
  end
end

# Wait for elastic and kibana services

ruby_block 'Wait for elasticsearch' do
  block do
    loop do
      break if begin
        TCPSocket.open(
          (node['elastic']['yml']['network']['host']).to_s,
          node['elastic']['yml']['http']['port']
        )
      rescue StandardError
        nil
      end
    end
  end
end

ruby_block 'Wait for kibana' do
  block do
    loop do
      break if begin
        TCPSocket.open(
          (node['kibana']['yml']['server']['host']).to_s,
          node['kibana']['yml']['server']['port']
        )
      rescue StandardError
        nil
      end
    end
  end
end

bash 'Waiting for kibana curl response...' do
  code <<-EOH
  until (curl -XGET https://#{node['kibana']['yml']['server']['host']}:#{node['kibana']['yml']['server']['port']} -u admin:admin -k); do
    printf 'Waiting for kibana....'
    sleep 5
  done
  EOH
end

log 'Access Kibana web interface' do
  message "URL: https://#{node['kibana']['yml']['server']['host']}
  user: admin
  password: admin"
  level :info
end
