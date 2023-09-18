# Cookbook Name:: khulnasoft-manager
# Attributes:: agent_conf
# Author:: Khulnasoft <info@khulnasoft.com

default['ossec']['centralized_configuration'] = {
    'enabled' => 'no',
    'path' => '/var/ossec/etc/shared/default'
}

# Example of configuration to include in agent.conf

# <agent_config os="Linux">
#     <localfile>
#         <location>/var/log/linux.log</location>
#         <log_format>syslog</log_format>
#     </localfile>
# </agent_config>

# Would require to be be declared like:

# default['ossec']['centralized_configuration']['conf']['agent_config']= [
#     {   "@os" => "Linux",
#         "localfile" => {
#             "location" => "/var/log/linux.log",
#             "log_format" => "syslog"
#         }
#     }
# ]
