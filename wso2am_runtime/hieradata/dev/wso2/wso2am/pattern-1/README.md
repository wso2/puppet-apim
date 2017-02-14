#WSO2 API Manager Pattern-1

![alt tag](https://github.com/rmsamitha/puppet-apim/blob/v2.1.0/wso2am/patterns/design/am-2.1.0-pattern-1.png)

This pattern consist of a stand-alone APIM setup with a single node deployment. The databases used in this pattern are
the embedded H2 databases. The only difference between this pattern-0 and pattern-1 is that, pattern-0 uses embedded
H2 databases and pattern-1 is configured to use external mysql databases.

Content of /opt/deployment.conf file should be similar to below to run the agent and setup this pattern in Puppet Agent.

```yaml
 product_name=wso2am
 product_version=2.1.0
 product_profile=default
 vm_type=openstack
 platform=default
 use_hieradata=true
 pattern=pattern-1

```