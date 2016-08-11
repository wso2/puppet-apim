# Deploy WSO2 Products with Puppet using Vagrant

This guide walks through the steps needed for deploying WSO2 products using Vagrant with VirtualBox as the provider.
Puppet will be used as the provisioning method in Vagrant and Hiera as the configuration data store.


## Pre-requisites

 * **[Vagrant](https://www.vagrantup.com)**
 * **[Virtualbox](https://www.virtualbox.org)** Vagrant hypervisor


## How to Use

1. Clone WSO2 APIM Puppet modules Git repository and consider this path as `PUPPET_HOME`:

    ````
    git clone https://github.com/wso2/puppet-apim.git
    ````

2. Create server configuration file:

    Rename `config.yaml.sample` to `config.yaml` and update the `/servers` section with required values. You can add more instances by adding more entries to `/servers` array. You can pass facters to Vagrant nodes through `/servers/*/facters` array.

    Additionally, you can copy a sample `config.yaml` file from the `samples` folder to quickly run a particular product on Vagrant.

3. Initialize and update `wso2base` submodule using following commands:

    ````
    git submodule init
    git submodule update
    ````
   
4. Download and copy Oracle JDK `1.7_80` distribution to the following path:

    ````
    <PUPPET_HOME>/modules/wso2base/files/jdk-7u80-linux-x64.tar.gz
    ````

5. Download and copy WSO2 APIM distribution (2.0.0 or 1.10.0 or 1.9.1) to Puppet module under `files` folder:

    ````
    <PUPPET_HOME>/modules/wso2am/files
    ````

5. Optionally update `<PUPPET_HOME>/hieradata` with required product configurations. `default` profile can be run on Vagrant without any changes to the Hiera data.

7. Execute the following command to start the VMs:

    ````
    vagrant up
    ````

For more information refer the [wiki](https://github.com/wso2/puppet-base/wiki) page.
