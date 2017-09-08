# WSO2 API Manager 2.1.0 Puppet Module

This is the Puppet Module for installing and configuring WSO2 API Manager in the 7 basic deployment
patterns. (plus single node deployment with embedded H2 databases : pattern-0). Configuration data is managed using
[Hiera](http://docs.puppetlabs.com/hiera/1/). Hiera provides a mechanism for separating configuration data from
Puppet scripts and managing them in a set of YAML files in a hierarchical manner.

This guide includes the the basic and common information related to each deployment pattern. Follow the instructions
here, to setup any deployment pattern. For specific information  on each pattern, refer the relevant README file in
each pattern related hieradata directory (i.e. for pattern 3 :
puppet-apim/wso2am_runtime/hieradata/dev/wso2/wso2am_runtime/pattern-3/README.md)

1. [Pattern 0 - README](hieradata/dev/wso2/wso2am_runtime/pattern-0/README.md)
2. [Pattern 1 - README](hieradata/dev/wso2/wso2am_runtime/pattern-1/README.md)
3. [Pattern 2 - README](hieradata/dev/wso2/wso2am_runtime/pattern-2/README.md)
4. [Pattern 3 - README](hieradata/dev/wso2/wso2am_runtime/pattern-3/README.md)
5. [Pattern 4 - README](hieradata/dev/wso2/wso2am_runtime/pattern-4/README.md)
6. [Pattern 5 - README](hieradata/dev/wso2/wso2am_runtime/pattern-5/README.md)
7. [Pattern 6 - README](hieradata/dev/wso2/wso2am_runtime/pattern-6/README.md)
7. [Pattern 7 - README](hieradata/dev/wso2/wso2am_runtime/pattern-7/README.md)

Follow the instructions stated in these relevant README files too, before running the agents.

Refer [Deployment Patterns](https://docs.wso2.com/display/AM210/Deployment+Patterns) for more on WSO2 APIM deployment
pattens.

Please note that the load balancer configurations are not done by puppet. All the pattern images consist of load
balancers so that it will be convenient to understand the connections when configured load balancing, which is
usually done in a production environment.

## How to Contribute
Follow the steps mentioned in the [wiki](https://github.com/wso2/puppet-base/wiki) to setup a development environment and update/create new puppet modules.

## Setup Puppet Environment

* Setup the puppet environment with the puppet modules wso2am_runtime, wso2am_analytics, wso2is_prepacked and wso2base.
* WSO2 APIM 2.1.0 , WSO2 APIM Analytics Server 2.1.0 and prepackaged-WSO2 Identity Server 5.3.0 puppet modules are
compatible and tested with
[puppet-base](https://github.com/wso2/puppet-base/) version 1.0.0 and [puppet-common](https://github.com/wso2/puppet-common) version 1.0.0
* So if using puppet-common's setup.sh to setup the PUPPET_HOME, use this version (1.0.0) of puppet-common.
* After setting up PUPPET_HOME using puppet-common's setup.sh, checkout the above mentioned compatible version of puppet-base.

## Supported Operating Systems

- Debian 6 or higher
- Ubuntu 14.04

## Supported Puppet Versions

- Puppet 3.x

## Configuring WSO2 APIM Analytics

Patterns 2-6 are configured with WSO2 APIM Analytics Server. So before setting up those patterns, setup WSO2
APIM Analytics Server using the pattern-1 in puppet module 'wso2am_analytics'.

## Packs to be Copied

Copy the following files to their corresponding locations, in the Puppet Master.

1. WSO2 API Manager 2.1.0 distribution (wso2am-2.1.0.zip)to `<PUPPET_HOME>/modules/wso2am/files`
2. JDK jdk-8u112-linux-x64.tar.gz distribution to `<PUPPET_HOME>/modules/wso2base/files`
3. (if using MySQL databases)MySQL JDBC driver JAR (mysql-connector-java-x.x.xx-bin.jar) into the <PUPPET_HOME>/modules/wso2am/files/configs/repository/components/lib
4. (if using svn based deployment synchronization)
    a. svnkit-all-1.8.7.wso2v1.jar into <PUPPET_HOME>/modules/wso2am/files/configs/repository/components/dropins
    b. trilead-ssh2-1.0.0-build215.jar into <PUPPET_HOME>/modules/wso2am/files/configs/repository/components/lib

## Running WSO2 API Manager with clustering in specific profiles

Hiera data sets matching the distributed profiles of WSO2 API Manager (`api-store`, `api-publisher`,
`api-key-manager`, `gateway-manager`, `geteway-worker`, `traffic-manager`) are shipped with clustering related
configuration already enabled. Therefore, only a few changes are needed to setup a distributed deployment in your
preferred deployment pattern, before running the puppet Agent. For more details refer the [Clustering the API
Manager](https://docs.wso2.com/display/AM210/Clustering+the+API+Manager) and [Clustering the Gateway(https://docs.wso2.com/display/CLUSTER44x/Clustering+the+Gateway) docs.

Do the changes in hieradata .yaml files in the related pattern.

1. Add/update the host name mapping list

Puppet will add the required host entries explicitly in /etc/hosts file in the Agent. For that you have to update the
 hosts mappings appropriately in default.yaml file (for patterns 0,1,2,7) or common.yaml (for patterns 3 to 6).

Ex:
   ```yaml
   wso2::hosts_mapping:
     apim_keymanager:
       ip: 192.168.57.186
       name: km.dev.wso2.org
     apim_store:
       ip: 192.168.57.21
       name: store.dev.wso2.org
     apim_publisher:
       ip: 192.168.57.219
       name: pub.dev.wso2.org
     apim_gateway:
       ip: 192.168.57.216
       name: mgt-gw.dev.wso2.org
     apim_gateway_worker:
       ip: 192.168.57.247
       name: gw.dev.wso2.org
     apim_traffic_manager:
       ip: 192.168.57.35
       name: tm.dev.wso2.org
     apim_analytics_server:
       ip: 192.168.57.29
       name: analytics.dev.wso2.org
     identity_server:
       ip: 192.168.57.135
       name: is.dev.wso2.org
   ```

2. Add the Well Known Address list for Gateway clusters and Publisher-Store cluster.

Pattern 3-6 consists of Gateway Cluster(s) and Publisher-Store clusters. If you are using those patterns, update
members list appropriately in relevant hiera files. Refer each pattern's README for more info.

3. Modify the MySQL based data sources to point to the external MySQL servers in all the hiera data files. (You have
just to replace the IP address, with the IP address of database server you are using). If you want
to use any other database except MySQL, update the data sources appropriately.

   Ex:
    ```yaml
    wso2am_db:
      name: WSO2AM_DB
      description: The datasource used for API Manager database
      driver_class_name: "%{hiera('wso2::datasources::mysql::driver_class_name')}"
      url: jdbc:mysql://192.168.100.1:3306/APIM_DB?autoReconnect=true
      username: "%{hiera('wso2::datasources::mysql::username')}"
      password: "%{hiera('wso2::datasources::mysql::password')}"
      jndi_config: jdbc/WSO2AM_DB
      max_active: "%{hiera('wso2::datasources::common::max_active')}"
      max_wait: "%{hiera('wso2::datasources::common::max_wait')}"
      test_on_borrow: "%{hiera('wso2::datasources::common::test_on_borrow')}"
      default_auto_commit: "%{hiera('wso2::datasources::common::default_auto_commit')}"
      validation_query: "%{hiera('wso2::datasources::mysql::validation_query')}"
      validation_interval: "%{hiera('wso2::datasources::common::validation_interval')}"

    ```
    If MySQL databases are used, uncomment the file_list entry for JDBC connector jar in relevant hiera data files.
    (In patterns 1,2 : default.yaml , in patterns 3-6 : common.yaml)
    ```yaml
    wso2::file_list:
      - "repository/components/lib/%{hiera('wso2::datasources::mysql::connector_jar')}"
    ```
    And update the jar file name appropriately if your file name is not mysql-connector-java-5.1.39-bin.jar (which is
     set as default) in default.yaml file (for patterns 0,1,2,7) or common.yaml (for patterns 3 to 6).
     ```yaml
     wso2::datasources::mysql::connector_jar: mysql-connector-java-5.1.39-bin.jar
     ```
4. Configure deployment synchronization in each Gateway related nodes. This can be done via multiple approaches.

* SVN Based

Patterns 3-6 are configured for svn based deployment synchronization, but they are commented out by default. Do
uncomment them.

    Ex:
    ```yaml
    wso2::dep_sync:
        enabled: true
        auto_checkout: true
        auto_commit: true
        repository_type: svn
        svn:
           url: http://svnrepo.example.com/repos/
           user: username
           password: password
           append_tenant_id: true
    ```
Copy the required jars for svn, into respective locations as described under the topic **Packs to be Copied**.
And uncomment the file_list entries for those two jar files in those hiera data files related to gateway nodes.
    ```yaml
    wso2::file_list:
       -  "repository/components/dropins/svnkit-all-1.8.7.wso2v1.jar"
       -  "repository/components/lib/trilead-ssh2-1.0.0-build215.jar"
    ```
* Rsync

Note that WSO2 now recommends rsync instead of svn, for deployment synchronization. So if you prefer to use rsync
follow the [WSO2 Docs on Configuring rsync for Deployment Synchronization](https://docs.wso2.com/display/CLUSTER44x/Configuring+rsync+for+Deployment+Synchronization)

## Running WSO2 API Manager with Secure Vault

WSO2 Carbon products may contain sensitive information such as passwords in configuration files. [WSO2 Secure Vault]
(https://docs.wso2.com/display/Carbon444/Securing+Passwords+in+Configuration+Files) provides a solution for securing such information.

Refer [Using WSO2 Carbon Secure Vault With WSO2 Puppet Modules](https://github.com/wso2/puppet-base/wiki/Using-WSO2-Carbon-Secure-Vault-With-WSO2-Puppet-Modules) for enabling secure vault.

---
**Note:**
Please note that the configuration [templates](./templates/repository/conf/) are written to match the default application of secure vault. If it is required to customize (encrypt additional passwords or remove encryption of passwords), please do the relevant changes to `ciper-tool.properties`, `cipher-text.properties` and the relevant [templates](./templates/repository/conf/).
---

## Keystore and client-truststore related configs

This repository includes custom keystore and clint-truststore in
puppet-apim/wso2am/files/configs/repository/resources/security for the initial setup (testing) purpose. (same files
are copied into the wso2am_analytics module and wso2is_prepacked module too). This wso2carbon.jks keystore is created
for CN=*.dev.wso2.org, and its self signed certificate is imported into the client-truststore.jks. When running
puppet agent, these two files replace the existing default wso2carbon.jks and client-truststore.jks files.

In the production environments, it is recommended to replace these with your own keystores and trust stores with CA
signed certificates. Also if also you change the host names given by-default in these patterns, you have to create
your own ones. For more info read [WSO2 Docs on Creating Keystores] (https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores).

Following steps can be followed to create new keystore and clint-truststore with self signed certificates.

1 . Generate a Java keystore and key pair with self-signed certificate:
```
	keytool -genkey -alias wso2carbon -keyalg RSA -keysize 2048 -keystore wso2carbon.jks -dname "CN=*.dev.wso2.org,OU=Home,O=Home,L=SL,S=WS,C=LK" -storepass wso2carbon -keypass wso2carbon -validity 2000
```
2 . Export a certificate from a keystore:
```
	keytool -export -keystore wso2carbon.jks -alias wso2carbon -file wso2carbon.cer
```
3 . Import a certificate into a trust store:
```
	keytool -import -alias wso2carbon -file wso2carbon.cer -keystore client-truststore.jks -storepass wso2carbon
```
