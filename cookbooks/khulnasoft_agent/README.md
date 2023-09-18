# Khulnasoft Agent cookbook

These cookbooks install and configure a Khulnasoft Agent on specified nodes.

Currently, the agent is automatically registered using enrollment. check the [documentation](https://documentation.khulnasoft.com/current/user-manual/registering/) for further information. The manager IP address has to be declared in the `node['ossec']['address']` attribute. 

### Attributes

* ``versions.rb`` contains version attributes to make it easier when it comes to bump version
* The rest of files contains all the default configuration files in order to generate *ossec.conf* 

Check ['ossec.conf']( https://documentation.khulnasoft.com/current/user-manual/reference/ossec-conf/index.html) documentation to see all configuration sections.

### Usage

Create a role following the ['khulnasoft_agent'](https://github.com/khulnasoft/khulnasoft-chef/roles/khulnasoft_agent.json) role structure and specify your desired configuration attributes. Note that **address** is mandatory.

Assign the current role to desired nodes and run ```chef-client``` on them.

For example:

```
{
    "name": "khulnasoft_agent",
    "description": "Khulnasoft agent",
    "json_class": "Chef::Role",
    "default_attributes": {
    },
    "override_attributes": {
      "ossec": {
        "address": "172.19.0.211"
      }
    },
    "chef_type": "role",
    "run_list": [
      "recipe[khulnasoft_agent::agent]"
    ],
    "env_run_lists": {
    }
}
```

### Recipes

#### agent.rb

Register agent by using agent enrollment. Also authd method is available but not enabled by default. You can declare the desired fields to customize the registration process. 

#### common.rb

It generates the ossec.conf file using Gyoku and restarts the khulnasoft-agent service

#### repository.rb

Declares repository of Khulnasoft and GPG keys based on different installations.

### References

Check https://documentation.khulnasoft.com/current/user-manual/agents/index.html for more information about Khulnasoft-Agent.

