# frozen_string_literal: true

# Cookbook Name:: opendistro
# Recipe:: default
# Author:: Khulnasoft <info@khulnasoft.com>

include_recipe 'opendistro::prerequisites'
include_recipe 'opendistro::repository'
include_recipe 'opendistro::elasticsearch'
include_recipe 'opendistro::kibana'
