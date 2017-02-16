#WSO2 API Manager Pattern-2

![alt tag](https://github.com/rmsamitha/puppet-apim/blob/v2.1.0/wso2am/patterns/design/am-2.1.0-pattern-2.png)

This pattern consist of a stand-alone APIM setup with a single node deployment, with a single wso2am-analytics server
instance. The databases used in this pattern are external mysql databases.

Content of /opt/deployment.conf file should be similar to below to run the agent and setup APIM node for this pattern
 in Puppet Agent.

```yaml
 product_name=wso2am_runtime
 product_version=2.1.0
 product_profile=default
 vm_type=openstack
 environment=dev
 platform=default
 use_hieradata=true
 pattern=pattern-1
```