# Cookbook Name:: khulnasoft-manager
# Attributes:: sca
# Author:: Khulnasoft <info@khulnasoft.com

default['ossec']['conf']['sca'] = {
    'enabled' => true,
    'scan_on_start' => true,
    'interval' => "12h",
    'skip_nfs' => true
}