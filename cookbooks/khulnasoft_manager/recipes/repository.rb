# Cookbook Name:: khulnasoft-manager
# Recipe:: repository
# Author:: Khulnasoft <info@khulnasoft.com>

case node['platform']
when 'debian', 'ubuntu'
  package 'lsb-release'

  ohai 'reload lsb' do
    plugin 'lsb'
    subscribes :reload, 'package[lsb-release]', :immediately
  end

  apt_repository 'khulnasoft' do
    key 'https://packages.khulnasoft.com/key/GPG-KEY-KHULNASOFT'
    uri "https://packages.khulnasoft.com/#{node['khulnasoft']['major_version']}/apt/"
    components ['main']
    distribution 'stable'
    action :add
  end

  apt_update
when 'redhat', 'centos', 'amazon', 'fedora', 'oracle'   
  yum_repository 'khulnasoft' do
    description 'KHULNASOFT Yum Repository - www.khulnasoft.com'
    gpgcheck true
    gpgkey 'https://packages.khulnasoft.com/key/GPG-KEY-KHULNASOFT'
    enabled true 
    baseurl "https://packages.khulnasoft.com/#{node['khulnasoft']['major_version']}/yum/"
    action :create
  end
when 'opensuseleap', 'suse'
  zypper_repository 'khulnasoft' do   
    description 'KHULNASOFT Zypper Repository - www.khulnasoft.com'
    gpgcheck true
    gpgkey 'https://packages.khulnasoft.com/key/GPG-KEY-KHULNASOFT'
    enabled true 
    baseurl "https://packages.khulnasoft.com/#{node['khulnasoft']['major_version']}/yum/"
    action :create
  end
else
  raise "Currently platforn not supported yet. Feel free to open an issue on https://www.github.com/khulnasoft/khulnasoft-chef if you consider that support for a specific OS should be added"
end


