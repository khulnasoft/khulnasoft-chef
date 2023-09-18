# frozen_string_literal: true

# Cookbook Name:: opendistro
# Recipe:: repository
# Author:: Khulnasoft <info@khulnasoft.com>

case node['platform']
when 'debian', 'ubuntu'
  package 'lsb-release'

  ohai 'reload lsb' do
    plugin 'lsb'
    subscribes :reload, 'package[lsb-release]', :immediately
  end

  # Install GPG key and add repository
  apt_repository 'khulnasoft' do
    uri "https://packages.wazuh.com/#{node['khulnasoft']['major_version']}/apt/"
    key 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
    distribution 'stable'
    components ['main']
  end

  # Update the package information
  apt_update
when 'redhat', 'centos', 'amazon', 'fedora', 'oracle'
  yum_repository 'khulnasoft' do
    description 'Opendistroforelasticseach Yum'
    baseurl "https://packages.wazuh.com/#{node['khulnasoft']['major_version']}/yum/"
    gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
    action :create
  end
when 'opensuseleap', 'suse'
  zypper_repository 'khulnasoft' do
    description 'Opendistroforelasticseach Zypper'
    baseurl "https://packages.wazuh.com/#{node['khulnasoft']['major_version']}/yum/"
    gpgkey 'https://packages.wazuh.com/key/GPG-KEY-WAZUH'
    action :create
    not_if do
      File.exist?('/etc/zypp/repos.d/khulnasoft.repo')
    end
  end
else
  raise 'Currently platforn not supported yet. Feel free to open an issue on https://www.github.com/khulnasoft/khulnasoft-chef if you consider that support for a specific OS should be added'
end
