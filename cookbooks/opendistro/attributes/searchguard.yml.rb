# frozen_string_literal: true

# Cookbook Name:: opendistro
# Attributes:: searchguard.yml
# Author:: Khulnasoft <info@khulnasoft.com>

# Searchguard configuraion file

default['search_guard']['yml'] = {
  'nodes' => {
    'elasticsearch' => {
      'ip' => [
        (node['elastic']['yml']['network']['host']).to_s
      ]
    },
    'kibana' => {
      'ip' => [
        (node['kibana']['yml']['server']['host']).to_s
      ]
    }
  }
}