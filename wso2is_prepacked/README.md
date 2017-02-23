# Pre-packaged WSO2 Identity Server (as Key Manager) Puppet Module

This repository contains the Puppet Module for installing and configuring Pre-packaged WSO2 Identity Server 5.3.0 (as
Key Manager) on various environments. Configuration data is managed using [Hiera](http://docs.puppetlabs
.com/hiera/1/). Hiera provides a mechanism for separating configuration data from Puppet scripts and managing them in
 a separate set of YAML files in a hierarchical manner.
This module will be used with pattern-7 in wso2am_runtime puppet module in this repository to configure IS as Key
Manager for WSO2 APIM. Supported with WSO2 APIM 2.1.0.

## Supported Operating Systems

- Debian 6 or higher
- Ubuntu 12.04 or higher

## Supported Puppet Versions

- Puppet 2.7, 3.x

## How to Contribute
Follow the steps mentioned in the [wiki](https://github.com/wso2/puppet-base/wiki) to setup a development environment
 and update/create new puppet modules.

## Packs to be Copied

Copy the following files to their corresponding locations.

1. [Pre-packaged WSO2 Identity Server 5.3.0 Key Manager pack](http://product-dist.wso2.com/downloads/api-manager/2.1
.0/identity-server/wso2is-5.3.0.zip) to `<PUPPET_HOME>/modules/wso2is/files`
2. JDK jdk-8u112-linux-x64.tar.gz distribution to `<PUPPET_HOME>/modules/wso2base/files`

## Running WSO2 Identity Server with clustering in specific profiles
No changes to Hiera data are required to run the distributed deployment of WSO2 Identity Server, other than pointing
to the correct resources such as the deployment synchronization and remote DB instances. For more details refer the
[Clustering Identity Server](https://docs.wso2.com/display/CLUSTER44x/Clustering+Identity+Server+5.1.0+and+5.2.0)
clustering guides.

1. If the Clustering Membership Scheme is `WKA`, add the Well Known Address list.

   Ex:
    ```yaml
    wso2::clustering :
        enabled: true
        local_member_host: "%{::ipaddress}"
        local_member_port: 4000
        membership_scheme: wka
        sub_domain: mgt
        wka:
           members:
             -
               hostname: 192.168.100.113
               port: 4000
             -
               hostname: 192.168.100.114
               port: 4000
    ```

2. Modify the MySQL based data sources to point to the external MySQL servers in hiera data files. (You have
just to replace the IP address, with the IP address of database server you are using). If you want
to use any other database except MySQL, update the data sources appropriately.
   Ex:
    ```yaml
    wso2::master_datasources:
      wso2_config_db:
        name: WSO2_CONFIG_DB
        description: The datasource used for config registry
        driver_class_name: "%{hiera('wso2::datasources::mysql::driver_class_name')}"
        url: jdbc:mysql://mysql-is-db:3306/IS_DB?autoReconnect=true
        username: "%{hiera('wso2::datasources::common::username')}"
        password: "%{hiera('wso2::datasources::common::password')}"
        jndi_config: jdbc/WSO2_CONFIG_DB
        max_active: "%{hiera('wso2::datasources::common::max_active')}"
        max_wait: "%{hiera('wso2::datasources::common::max_wait')}"
        test_on_borrow: "%{hiera('wso2::datasources::common::test_on_borrow')}"
        default_auto_commit: "%{hiera('wso2::datasources::common::default_auto_commit')}"
        validation_query: "%{hiera('wso2::datasources::mysql::validation_query')}"
        validation_interval: "%{hiera('wso2::datasources::common::validation_interval')}"

    ```
 If MySQL databases are used, uncomment the file_list entry for JDBC connector jar in the hiera data file.
    ```yaml
    wso2::file_list:
      - "repository/components/lib/%{hiera('wso2::datasources::mysql::connector_jar')}"
    ```
3. Configure registry mounting

   Ex:
    ```yaml
    wso2_config_db:
      path: /_system/config
      target_path: /_system/config
      read_only: false
      registry_root: /
      enable_cache: true

    wso2_gov_db:
      path: /_system/governance
      target_path: /_system/governance
      read_only: false
      registry_root: /
      enable_cache: true
    ```

4. Configure deployment synchronization if required.

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

## Running WSO2 Identity Server with Secure Vault
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

## Keystore and client-truststore related configs

This repository includes custom keystore and clint-truststore in
puppet-apim/wso2am/files/configs/repository/resources/security for the initial setup (testing) purpose. (same files
are copied into the wso2am_runtime module and wso2am_analytics module too). This wso2carbon.jks keystore is created for
CN=*.dev.wso2.org, and its self signed certificate is imported into the client-truststore.jks. When running puppet
agent, these two files replace the existing default wso2carbon.jks and client-truststore.jks files.

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