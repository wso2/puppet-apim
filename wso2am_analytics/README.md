# WSO2 API Manager Analytics Server 2.1.0 Puppet Module

This puppet module contains the WSO2 API Manager Analytics Server, v2.1.0 Puppet Module. This module is used to
configure analytics for WSO2 APIM 2.1.0 , hence will be used in combination with the puppet module 'wso2am_runtime' in
this repository.

This contains a single pattern, which is a single node deployment. Setup the WSO2 APIM Analytics Server, before setting
 up the WSO2 APIM patterns, which consist of Analytics Server.

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
- Ubuntu 12.04 or higher

## Supported Puppet Versions

- Puppet 2.7, 3.x

## Packs to be Copied

Copy the following files to their corresponding locations, in the Puppet Master.

1. WSO2 API Manager Analytics Server 2.1.0 distribution (wso2am-analytics-2.1.0.zip)to
`<PUPPET_HOME>/modules/wso2am_analytics/files`
2. JDK jdk-8u112-linux-x64.tar.gz distribution to `<PUPPET_HOME>/modules/wso2base/files`
3. (if using MySQL databases)MySQL JDBC driver JAR (mysql-connector-java-x.x.xx-bin.jar) into the
<PUPPET_HOME>/modules/wso2am_analytics/files/configs/repository/components/lib

## Configure Datasources

Modify the MySQL based data sources to point to the external MySQL servers in the hiera data file. (You
 have just to replace the IP address, with the IP address of database server you are using). If you want
to use any other database except MySQL, update the data sources appropriately.

Ex:
   ```yaml
    wso2::analytics_datasources:
      wso2_analytics_event_store_db:
        name: WSO2_ANALYTICS_EVENT_STORE_DB
        description: The datasource used for analytics record store
        driver_class_name: "%{hiera('wso2::datasources::mysql::driver_class_name')}"
        url: jdbc:mysql://192.168.57.210:3306/analyticseventstoredb?autoReconnect=true
        username: "%{hiera('wso2::datasources::mysql::username')}"
        password: "%{hiera('wso2::datasources::mysql::password')}"
        max_active: "%{hiera('wso2::datasources::common::max_active')}"
        max_wait: "%{hiera('wso2::datasources::common::max_wait')}"
        test_on_borrow: "%{hiera('wso2::datasources::common::test_on_borrow')}"
        default_auto_commit: "%{hiera('wso2::datasources::common::default_auto_commit')}"
        validation_query: "%{hiera('wso2::datasources::mysql::validation_query')}"
        validation_interval: "%{hiera('wso2::datasources::common::validation_interval')}"
   ```
   If MySQL databases are used, uncomment the file_list entry for JDBC connector jar

   ```yaml
    wso2::file_list:
      - "repository/components/lib/%{hiera('wso2::datasources::mysql::connector_jar')}"
   ```
    And update the jar file name appropriately if your file name is not mysql-connector-java-5.1.39-bin.jar (which is
     set as default) in default.yaml file.
    ```yaml
    wso2::datasources::mysql::connector_jar: mysql-connector-java-5.1.39-bin.jar
    ```
## Running WSO2 API Manager Analytics Server with Secure Vault

WSO2 Carbon products may contain sensitive information such as passwords in configuration files. [WSO2 Secure Vault]
(https://docs.wso2.com/display/Carbon444/Securing+Passwords+in+Configuration+Files) provides a solution for securing such information.

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

This repository includes custom keystore and clint-truststore in
puppet-apim/wso2am_analytics/files/configs/repository/resources/security for the initial setup (testing) purpose.
(same files are copied into the wso2am_runtime module and wso2is_prepacked module too). This wso2carbon.jks keystore is
created for CN=*.dev.wso2.org, and its self signed certificate is imported into the client-truststore.jks. When running puppet agent, these two files replace the existing default wso2carbon.jks and client-truststore.jks files.

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

## Running Agent

Content of /opt/deployment.conf file should be similar to below to run the agent and setup WSO2 APIM Analytics Server
 in Puppet Agent.
```yaml
product_name=wso2am_analytics
product_version=2.1.0
product_profile=default
vm_type=openstack
environment=dev
platform=default
use_hieradata=true
pattern=pattern-1
```
