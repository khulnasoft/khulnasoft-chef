# frozen_string_literal: true

# Cookbook Name:: elastic-stack
# Attributes:: api
# Author:: Khulnasoft <info@khulnasoft.com>

default['kibana']['khulnasoft_api_credentials'] = [
  {
    'id' => 'default',
    'url' => 'https://localhost',
    'port' => 55000,
    'username' => 'khulnasoft',
    'password' => 'khulnasoft',
  }
]
