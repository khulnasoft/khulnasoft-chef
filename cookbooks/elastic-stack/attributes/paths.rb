# frozen_string_literal: true

# Cookbook Name:: elastic-stack
# Attributes:: paths
# Author:: Khulnasoft <info@khulnasoft.com>

# Elastic paths
default['elastic']['config_path'] = '/etc/elasticsearch'

# Kibana paths
default['kibana']['package_path'] = '/usr/share/kibana'
default['kibana']['config_path'] = '/etc/kibana'
