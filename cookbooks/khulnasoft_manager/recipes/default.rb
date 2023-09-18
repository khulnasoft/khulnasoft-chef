# Cookbook Name:: khulnasoft-manager
# Recipe:: default
# Author:: Khulnasoft <info@khulnasoft.com>

include_recipe 'khulnasoft_manager::prerequisites'
include_recipe 'khulnasoft_manager::repository'
include_recipe 'khulnasoft_manager::manager'
