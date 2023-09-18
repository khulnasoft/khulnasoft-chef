# Cookbook Name:: khulnasoft-manager
# Attributes:: alerts
# Author:: Khulnasoft <info@khulnasoft.com

default['ossec']['conf']['alerts'] = {
    'log_alert_level' => 3,
    'email_alert_level' => 12
}