# Cookbook Name:: khulnasoft-manager
# Attributes:: ruleset
# Author:: Khulnasoft <info@khulnasoft.com

# Ruleset settings (Manager)
default['ossec']['conf']['ruleset'] = {
    'decoder_dir' => [
        'ruleset/decoders', 
        'etc/decoders'
    ],
    'rule_dir' => [
        'ruleset/rules', 
        'etc/rules'
    ],
    'rule_exclude' => '0215-policy_rules.xml',
    'list' => [
        'etc/lists/audit-keys', 
        'etc/lists/security-eventchannel', 
        'etc/lists/amazon/aws-eventnames'
    ]
}
