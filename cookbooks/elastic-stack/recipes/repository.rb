# frozen_string_literal: true

# Cookbook Name:: elastic-stack
# Recipe:: repository
# Author:: Khulnasoft <info@khulnasoft.com>

case node['platform']
when 'ubuntu', 'debian'
  package 'lsb-release'

  ohai 'reload lsb' do
    plugin 'lsb'
    subscribes :reload, 'package[lsb-release]', :immediately
  end

  apt_repository "elastic-#{node['elk']['major_version']}" do
    key 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
    uri "https://artifacts.elastic.co/packages/#{node['elk']['major_version']}/apt"
    components ['main']
    distribution 'stable'
    action :add
  end

  apt_update
when 'redhat', 'centos', 'amazon', 'fedora', 'oracle'
  yum_repository 'elastic' do
    description "Elasticsearch repository for #{node['elk']['major_version']} packages"
    gpgcheck true
    gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
    enabled true
    baseurl "https://artifacts.elastic.co/packages/#{node['elk']['major_version']}/yum"
    action :create
  end
when 'opensuseleap', 'suse'
  zypper_repository 'elastic' do
    description "Elasticsearch repository for #{node['elk']['major_version']} packages"
    gpgcheck true
    gpgkey 'https://artifacts.elastic.co/GPG-KEY-elasticsearch'
    enabled true
    baseurl "https://artifacts.elastic.co/packages/#{node['elk']['major_version']}/yum"
    action :create
  end
else
  raise 'Currently platforn not supported yet. Feel free to open an issue on https://www.github.com/khulnasoft/khulnasoft-chef if you consider that support for a specific OS should be added'
end
