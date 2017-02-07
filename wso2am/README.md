# WSO2 API Manager Puppet Module

This repository contains the Puppet Module for installing and configuring WSO2 API Manager in the 6 basic deployment patterns. (plus single node deployment with embedded H2 databases). Configuration data is managed using [Hiera](http://docs.puppetlabs.com/hiera/1/). Hiera provides a mechanism for separating configuration data from Puppet scripts and managing them in a set of YAML files in a hierarchical manner.

This guide includes the the basic and common information related to each deployment pattern. For detailed description on each pattern, refer the relavent README file in each pattern related hieradata directory. (i.e. puppet-apim/wso2am/hieradata/dev/wso2/wso2am/pattern-x/README.md) 

## Setup Puppet Environment

Use wso2/puppet-common repository to setup the puppet environment with the puppet modules wso2am, wso2am_analytics and wso2base.

## Supported Operating Systems

- Debian 6 or higher
- Ubuntu 12.04 or higher

## Supported Puppet Versions

- Puppet 2.7, 3.X

## Packs to be Copied

Copy the following files to their corresponding locations, in the Puppet Master node.

1. WSO2 API Manager 2.1.0 distribution (wso2am-2.1.0.zip)to `<PUPPET_HOME>/modules/wso2am/files`
2. JDK jdk-8u112-linux-x64.tar.gz distribution to `<PUPPET_HOME>/modules/wso2base/files`

## Running WSO2 API Manager with clustering in specific profiles

Hiera data sets matching the distributed profiles of WSO2 API Manager (`api-store`, `api-publisher`, `api-key-manager`, `gateway-manager`, `geteway-worker`, `traffic-manager`) are shipped with clustering related configuration already enabled. Therefore, only a few changes are needed to setup a distributed deployment in your preferred deployment pattern, before running the puppet Agent. For more details refer the [WSO2 API Manager 2.0.0](https://docs.wso2.com/display/CLUSTER44x/Clustering+API+Manager+2.0.0) and [Clustering the Gateway(https://docs.wso2.com/display/CLUSTER44x/Clustering+the+Gateway) clustering guides.

Do the changes in hieradata .yaml files in the related pattern.

1. Add/update the host name mapping list

Puppet will add the required host entries explicitely in /etc/hosts file in the Agent. For that you have to update the hosts mappings appropriately in default.yaml file (for patterns 0 to 2) or common.yaml (for patterns 3 to 6).

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
   ```

2. Add the Well Known Address list for Gateway and Publisher/Store clusters.

Pattern 3-6 consists of a Gateway Clusters adn Publisher/Store clusters. If you are using those patterns, update members list appropriately in relavant hiera files. Refer each pattern's README for more info.

3. Uncomment and modify the MySQL based data sources to point to the external MySQL servers in all the hiera data files. (You have just to replace the ip)

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
4. Uncomment (and optionally configure) deployment synchronization in each Gateway related nodes. (Patterns 3-6 are configured for svn based deployment synchronization, but they are commented out.) 

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

## Running WSO2 API Manager with Secure Vault

WSO2 Carbon products may contain sensitive information such as passwords in configuration files. [WSO2 Secure Vault](https://docs.wso2.com/display/Carbon444/Securing+Passwords+in+Configuration+Files) provides a solution for securing such information.

Uncomment and modify the below changes in Hiera file to apply Secure Vault.

1. Enable Secure Vault

    ```yaml
    wso2::enable_secure_vault: true
    ```

2. Add Secure Vault configurations as below

    ```yaml
    wso2::secure_vault_configs:
      <secure_vault_config_name>:
        secret_alias: <secret_alias>
        secret_alias_value: <secret_alias_value>
        password: <password>
    ```

    Ex:
    ```yaml
    wso2::secure_vault_configs:
      key_store_password:
        secret_alias: Carbon.Security.KeyStore.Password
        secret_alias_value: repository/conf/carbon.xml//Server/Security/KeyStore/Password,false
        password: wso2carbon
    ```
    
3. Add Cipher Tool configuration file templates to `template_list`

    ```yaml
    wso2::template_list:
      - repository/conf/security/cipher-text.properties
      - repository/conf/security/cipher-tool.properties
      - bin/ciphertool.sh
    ```
Please add the `password-tmp` template also to `template_list` if the `vm_type` is not `docker` when you are running the server in `default` platform.

## Kestore and client-truststore related configs

This repository inludes custom keystore and clint-truststore in puppet-apim/wso2am/files/configs/repository/resources/security for the initial setup (testing) purpose. (same files are copied into the wso2am_analytics module too) This wso2carbon.jks keystore is created for CN=*.dev.wso2.org, and its self signed certificate is imported into the client-truststore.jks. When running puppet agent, these two files replace the existing default wso2carbon.jks and client-truststore.jks files. 

In the production environments, it is recommended to replace these with your own keystores and trust stores with CA signed certificates. Also if also you change the hostnames given by-default in these patterns, you have create your own ones. For more info read [WSO2 Docs on Creating Keystores] (https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores).

Following steps can be followed to create new keystore and clint-truststore with self signed certificates.

1. Generate a Java keystore and key pair with self-signed certificate:
```
	keytool -genkey -alias wso2carbon -keyalg RSA -keysize 2048 -keystore wso2carbon.jks -dname "CN=*.dev.wso2.org,OU=Home,O=Home,L=SL,S=WS,C=LK" -storepass wso2carbon -keypass wso2carbon -validity 2000
```
2. Export a certificate from a keystore:
```
	keytool -export -keystore wso2carbon.jks -alias wso2carbon -file wso2carbon.cer
```
3. Import a certificate into a trust store:
```
	keytool -import -alias wso2carbon -file wso2carbon.cer -keystore client-truststore.jks -storepass wso2carbon
```
