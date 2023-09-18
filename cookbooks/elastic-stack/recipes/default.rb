# frozen_string_literal: true

# Cookbook Name:: elastic-stack
# Recipe:: default
# Author:: Khulnasoft <info@khulnasoft.com>

include_recipe 'elastic-stack::prerequisites'
include_recipe 'elastic-stack::repository'
include_recipe 'elastic-stack::elasticsearch'
include_recipe 'elastic-stack::kibana'
