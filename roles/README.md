# Khulnasoft roles

There are 5 types of roles:

1. **khulnasoft_server**: Khulnasoft Manager and Filebeat
2. **khulnasoft_server_oss**: Khulnasoft Manager and Filebeat OSS
3. **khulnasoft_agent**: Khulnasoft Agent
4. **elastic_stack**: Elasticsearch and Kibana
5. **opendistro**: Elasticsearch OSS and Kiban OSS

## Important attributes

### khulnasoft-manager
-----------------

**How to bind a specific IP address to manager?**

In case you have a non single-node installation and want to bind a specifi IP address to the manager 
the followig attributes must be override:

* ```node['api]['ip']```: the IP address bind to the API
* ```node['api]['port']```: the port bind to the API

### filebeat and filebeat-oss
-----------------------------

* ```node['filebeat']['yml']['elasticsearch']['hosts']```: array with all Elastic nodes IP and port

### elastic-stack and opendistro
--------------------------------
* ``node['elastic']['yml']['network']['host']``: IP address bind to elasticsearch node
* ``node['elastic']['yml']['http']['port']``: port bind to elasticsearch node
* ``node['kibana']['yml']['server']['host']``: IP address bind to kibana node
* ``node['kibana']['yml']['server']['port']``: port bind to elasticsearch node
* ``node['kibana']['khulnasoft_api_credentials']``: array with all khulnasoft manager nodes, specifying api credentials