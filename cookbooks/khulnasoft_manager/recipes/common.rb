# Cookbook Name:: khulnasoft-manager
# Recipe:: common
# Author:: Khulnasoft <info@khulnasoft.com>

ruby_block 'ossec install_type' do
  block do
    if node['recipes'].include?('ossec::default')
      type = 'local'
    else
      type = "test"
    end

    node.normal['ossec']['install_type'] = type
  end
end

# Gyoku renders the XML.
chef_gem 'gyoku' do
  compile_time false if respond_to?(:compile_time)
end

## Generate Ossec.conf
file "#{node['ossec']['dir']}/etc/ossec.conf" do
  owner 'root'
  group 'ossec'
  mode '0440'
  manage_symlink_source true
  notifies :restart, 'service[khulnasoft]'

  content lazy {
    all_conf = node['ossec']['conf'].to_hash
    Chef::OSSEC::Helpers.ossec_to_xml('ossec_config' => all_conf)
  }
  
end

## Generate agent.conf

if node['ossec']['centralized_configuration']['enabled'] == 'yes' && !node['ossec']['centralized_configuration']['conf'].nil?

  file "#{node['ossec']['centralized_configuration']['path']}/agent.conf" do
    owner 'root'
    group 'ossec'
    mode '0440'
    content lazy {
      all_conf = node['ossec']['centralized_configuration']['conf'].to_hash
      Chef::OSSEC::Helpers.ossec_to_xml(all_conf)
    }
    verify "/var/ossec/bin/verify-agent-conf -f #{node['ossec']['centralized_configuration']['path']}/agent.conf"
  end

end

