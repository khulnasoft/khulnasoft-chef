# frozen_string_literal: true

# Cookbook Name:: elastic-stack
# Attributes:: versions
# Author:: Khulnasoft <info@khulnasoft.com>

# ELK
default['elk']['major_version'] = '7.x'
default['elk']['patch_version'] = '7.11.2'

# Khulnasoft
default['khulnasoft']['major_version'] = '4.x'
default['khulnasoft']['minor_version'] = '4.4'
default['khulnasoft']['patch_version'] = '4.4.0'

# Kibana
default['khulnasoft']['kibana_plugin_version'] = '4.4.0_7.10.2'
