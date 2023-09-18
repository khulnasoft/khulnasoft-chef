# Cookbook Name:: filebeat-oss
# Attribute:: filebeat.yml
# Author:: Khulnasoft <info@khulnasoft.com>

default['filebeat']['yml'] = {
    'output' => {
        'elasticsearch' => {
            'hosts' => [
                {
                    'ip' => '0.0.0.0',
                    'port' => 9200
                }
            ]
        }
    }
}


