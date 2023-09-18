# Khulnasoft Manager cookbook

This cookbook installs and configure Khulnasoft Manager on specified nodes.

There are two types of manager installations:

1. Without filebeat-oss
2. With filebeat-oss

Dependending on your choice, install elastic-stack or opendistro cookbooks respectively.

### Attributes 

* ``api.rb`` contains API IP and port
* ``versions.rb`` contains version attributes to make it easier when it comes to bump version
* The rest of files contains all the default configuration files in order to generate ossec.conf 

Check ['ossec.conf'](https://documentation.khulnasoft.com/current/user-manual/reference/ossec-conf/) documentation
to see all configuration sections.

### Usage

Create a role, `khulnasoft_server`. Add attributes per above as needed to customize the installation.

```
  {
    "name": "khulnasoft_server",
    "description": "Khulnasoft Server host",
    "json_class": "Chef::Role",
    "default_attributes": {

    },
    "override_attributes": {

    },
    "chef_type": "role",
    "run_list": [
      "recipe[khulnasoft_manager::default]",
      "recipe['filebeat::default]"
    ],
    "env_run_lists": {

    }
  }
```

If you want to build a Khulnasoft cluster, you need to create two roles, one role for the **Master** and another one for **Worker**:

```
  {
    "name": "khulnasoft_manager_master",
    "description": "Khulnasoft Manager master node",
    "json_class": "Chef::Role",
    "default_attributes": {

    },
    "override_attributes": {
      "ossec": {
        "cluster_disabled": "no",
        "conf": {
          "server": {
            "cluster": {
              "node_name": "master01",
              "node_type": "master",
              "disabled": "no",
              "nodes": {
                "node": ["172.16.10.10", "172.16.10.11"]
              "key": "596f6b328c8ca831a03f7c7ca8203e8b"
            }
          }
        }
    },
    "chef_type": "role",
    "run_list": [
      "recipe[khulnasoft_manager::default]",
      "recipe[filebeat::default]"
    ],
    "env_run_lists": {

    }
  }

  {
    "name": "khulnasoft_manager_worker",
    "description": "Khulnasoft Manager worker node",
    "json_class": "Chef::Role",
    "default_attributes": {

    },
    "override_attributes": {
      "ossec": {
        "cluster_disabled": "no",
        "conf": {
          "server": {
            "cluster": {
              "node_name": "worker01",
              "node_type": "worker",
              "disabled": "no",
              "nodes": {
                "node": ["172.16.10.10", "172.16.10.11"]
              "key": "596f6b328c8ca831a03f7c7ca8203e8b"
            }
          }
        }
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

Check [cluster documentation](https://documentation.khulnasoft.com/current/user-manual/configuring-cluster/index.html) for more details

### Recipes

#### manager.rb

Installs the khulnasoft-manager and required dependencies. Also creates the *local_rules.xml* and *local_decoder.xml* files.

#### common.rb

Generates the ossec.conf file using Gyoku.

#### repository.rb 

Declares khulnasoft repository and GPG key URIs.

#### prerequisites.rb
Install prerequisites to install Khulnasoft manager

### References

Check [Khulnasoft server administration](https://documentation.khulnasoft.com/current/user-manual/manager/index.html) for more information about Khulnasoft Server.
