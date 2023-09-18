# Cookbook Name:: khulnasoft-manager
# Attributes:: cluster
# Author:: Khulnasoft <info@khulnasoft.com

# Cluster settings
default['ossec']['conf']['cluster'] = {
    'name' => 'khulnasoft',
    'node_name' => 'node01',
    'node_type' => 'master',
    'key' => '',
    'port' => 1516,
    'bind_addr' => '0.0.0.0',
    'nodes' => {
        'node' => "NODE_IP"
    },
    'hidden' => false,
    'disabled' => true
}
