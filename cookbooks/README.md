
Khulnasoft cookbooks
====================================

Requirements
------------
#### Platforms
Tested on Ubuntu and CentOS, but should work on any Unix/Linux platform supported by Khulnasoft. Installation by default is done from packages.

These cookbooks don't configure Windows systems yet. For manual agent installation on Windows, check the [documentation](https://documentation.khulnasoft.com/current/installation-guide/khulnasoft-agent/khulnasoft_agent_package_windows.html)

Attributes
----------

All default attributes files are defined in the ```attributes/``` folder of each cookbook. Chef applies attributes from all attribute files regardless of which recipes were executed. It's important to mention that Chef will load ```default.rb``` first and then will proceed alphabetically. 

### ossec.conf

OSSEC's configuration is mainly read from an XML file called `ossec.conf`. You can directly control the contents of this file using node attributes under `node['ossec']['conf']`. These attributes are mapped to XML using Gyoku. See the [Gyoku site](https://github.com/savonrb/gyoku) for details on how this works.

Values `true` and `false`  are automatically mapped to `"yes"` and `"no"` as OSSEC expects the latter.

`ossec.conf` makes use of XML attributes so you can generally construct nested hashes in the usual fashion. Where an attribute is required, you can do it like this:

```ruby
default['ossec']['conf']['all']['syscheck']['directories'] = [
  { '@check_all' => true, 'content!' => '/bin,/sbin' },
  '/etc,/usr/bin,/usr/sbin'
]
```

This produces:

```xml
<syscheck>
  <directories check_all="yes">/bin,/sbin</directories>
  <directories>/etc,/usr/bin,/usr/sbin</directories>
</syscheck>
```

## Customize Installation

**Important note:** Gyoku will hash the defined attributes and the ```ossec.conf``` file will only contain the declared attributes, via default attributes or overridden ones. Any other information will be overwritten and deleted from the file.

If you want to add new fields to customize your installation, you can declare it as a default attribute in its respective .rb file in the attributes folder or add it manually to the role.

For example: To enable cluster configuration, the following line would be replaced in ```/cookbooks/khulnasoft_manager/attributes/cluster.rb ``` file:

`````` ruby
default['ossec']['conf']['cluster'] = {
  ...
  'disabled' => false
}
``````

This will transform the **disabled** field of from:

```xml
<cluster>
  <name>khulnasoft</name>
  <node_name>manager_01</node_name>
  <node_type>master</node_type>
  <key>ugdtAnd7Pi9myP7CVts4qZaZQEQcRYZa</key>
  <port>1516</port>
  <bind_addr>0.0.0.0</bind_addr>
  <nodes>
    <node>master</node>
  </nodes>
  <hidden>no</hidden>
  <disabled>yes</disabled>
</cluster>
```

To:

```xml
<cluster>
  <name>khulnasoft</name>
  <node_name>manager_01</node_name>
  <node_type>master</node_type>
  <key>ugdtAnd7Pi9myP7CVts4qZaZQEQcRYZa</key>
  <port>1516</port>
  <bind_addr>0.0.0.0</bind_addr>
  <nodes>
    <node>master</node>
  </nodes>
  <hidden>no</hidden>
  <disabled>no</disabled>
</cluster>
```

In case you want to customize your installation using roles, you can declare attributes like this: 

```json
{
  "name": "khulnasoft_server",
  "description": "Khulnasoft Server Role",
  "json_class": "Chef::Role",
  "default_attributes": {
    "ossec": {
        "cluster":{
            "disabled" : "false"
        }
    }
  },
  "override_attributes": {

  },
  "chef_type": "role",
  "run_list": [
    "recipe[khulnasoft_manager::default]",
    "recipe[filebeat::default]"
  ],
  "env_run_lists": {

  }
}
```

The same example applies for the rest of cookbooks and it's own attributes.

You can get more info about attributes and how the work on the chef documentation: https://docs.chef.io/attributes.html

### Centralized Configuration

You can set up your Khulnasoft [Centralized Configuration](https://documentation.khulnasoft.com/current/user-manual/reference/centralized-configuration.html#centralized-configuration-process) with Chef.

In order to achieve this, the following steps are required:

##### Enable the `agent.conf` configuration

The easiest way to achieve this is to modify the Khulnasoft Manager attributes in the role

```json
{
  "name": "khulnasoft_server",
  "description": "Khulnasoft Server Role",
  "json_class": "Chef::Role",
  "default_attributes": {
    "ossec": {
        "centralized_configuration":{
            "enabled" : "yes",
            "path": "/var/ossec/etc/shared/default",
        }
      }
    },
  "override_attributes": {

  },
  "chef_type": "role",
  "run_list": [
    "recipe[khulnasoft_manager::default]",
    "recipe[filebeat::default]"
  ],
  "env_run_lists": {

  }
}
```

This, will render all `['ossec']['centralized_configuration']['conf']['agent_config']` variables and convert them to XML using Gyoku

For example, the following attribute:

```ruby
default['ossec']['centralized_configuration']['conf']['agent_config']= [
  {   "@os" => "Linux",
      "localfile" => {
          "location" => "/var/log/linux.log",
          "log_format" => "syslog"
      }
  }
]
```

Generates this XML in the `agent.conf` file:

```xml
<agent_config os="Linux">
    <localfile>
        <location>/var/log/linux.log</location>
        <log_format>syslog</log_format>
    </localfile>
</agent_config>
```