# Cookbook Name:: khulnasoft-manager
# Attributes:: logging
# Author:: Khulnasoft <info@khulnasoft.com

# Choose between plain or json format (or both) for internal logs
default['ossec']['conf']['logging'] = {
    'log_format' => 'plain'
}