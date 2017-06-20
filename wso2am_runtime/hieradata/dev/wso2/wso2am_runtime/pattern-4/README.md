# WSO2 API Manager Pattern-4

![pattern-design](../../../../../patterns/design/am-2.1.0-pattern-4.jpg)

This pattern consist of a fully distributed APIM setup including two Gateway clusters each with one manager and one worker, with a single
wso2am-analytics server instance. The eight hiera data .yaml files (in spite of  common.yaml) here are for the 8 APIM nodes.
 The databases used in this pattern are external mysql databases. And please note that the hiera data files of gateway nodes are named with 
 the suffixes 'env1' or 'env2' which refers to the environment they could be existing in. But please consider that the two gateway clusters in 
 this pattern are there, just to convey that they are in two (gateway)environments. You can have them in any preferred environment. (for example LAN and DMZ)
 
Please follow the basic instructions in this [README](../../../../../README.md) before following this guide.

## Deployment.conf file

Content of /opt/deployment.conf file should be similar to below format to run the agent and setup the respective APIM
 node for this pattern. Please note to put the respective Hieradata .yaml file name, without extension to the
 **product_profile** parameter.

```yaml
 product_name=wso2am_runtime
 product_version=2.1.0
 product_profile=<hiera_file_name_without_extension>
 vm_type=openstack
 environment=dev
 platform=default
 use_hieradata=true
 pattern=pattern-4
```
e.g.:- To setup Gateway Manager node in the Gateway Environment-2:

```yaml
 product_name=wso2am_runtime
 product_version=2.1.0
 product_profile=gateway-manager-env2
 vm_type=openstack
 environment=dev
 platform=default
 use_hieradata=true
 pattern=pattern-4
```

## Node Details

Following table contains the APIM node instances with their respective hiera data .yaml file names and the host names
used in each instance.

   APIM Node            | Hieradata file            | Hostname
   -------------        |-----------------------    | ------------------
   Publisher            | api-publisher.yaml        | pub.dev.wso2.org
   Store                | api-store.yaml            | store.dev.wso2.org
   Gateway Manager-ENV1 | gateway-manager-env1.yaml | mgt-gw.dev.wso2.org
   Gateway Worker-ENV1  | gateway-worker-env1.yaml  | gw.dev.wso2.org
   Gateway Manager-ENV2 | gateway-manager-env2.yaml | env2-mgt-gw.dev.wso2.org
   Gateway Worker-ENV2  | gateway-worker-env2.yaml  | env2-gw.dev.wso2.org
   Key Manager          | api-key-manager.yaml      | km.dev.wso2.org
   Traffic Manager      | traffic-manager.yaml      | tm.dev.wso2.org

Hostname used for the Analytics Server : **analytics.dev.wso2.org**


## Update wka list for clusters in the deployment

There are 3 clusters in this deployment pattern. Required configurations are already added, but WKA IP addresses
should be updated in the respective hiera data files

1.Publisher-Store Cluster

This is a cluster of Publisher node and Store node.
Update the wka list in both api-publisher.yaml and store.yaml files with the IP addresses of Publisher and Store nodes.
```yaml
  wka:
    members:
      -
        hostname: 192.168.57.219
        port: 4000
      -
        hostname: 192.168.57.21
        port: 4000
```
2.Gateway Clusters

There are 2 Gateway clusters in this pattern. These are there to represent that they are in 2 environments. (for example, DMZ and LAN). We will refer them as 'Gateway Environment-1' and 'Gateway Environment-2'. 
Each of these 2 clusters consist of a Gateway Manager node and a Gateway Worker node.
Required configurations are already added, but WKA IP addresses should be updated in the respective hiera data files

  * For the Gateway cluster in the Gateway Environment-1:
    -Update the wka list in both gateway-manager-env1.yaml and gateway-worker-env1.yaml files with the IP addresses of Gateway Manager node and Gateway Worker node in the Gateway Environment-1.

```yaml
  wka:
    members:
      -
        hostname: 192.168.57.216
        port: 4000
      -
        hostname: 192.168.57.247
        port: 4000
```

  * For the Gateway cluster in the Gateway Environment-2:
    -Update the wka list in both gateway-manager-env2.yaml and gateway-worker-env2.yaml files with the IP addresses of Gateway Manager node and Gateway Worker node in the Gateway Environment-2 .

```yaml
  wka:
    members:
      -
        hostname: 192.168.57.5
        port: 4000
      -
        hostname: 192.168.57.218
        port: 4000
```
