# Puppet Modules for WSO2 API Manager

This repository contains the Puppet modules for profiles related to WSO2 API Manager and API Manager Analytics.

## Quick Start Guide
1. Download an updated wso2am-2.6.0.zip or wso2am-analytics-2.6.0.zip to your preferred deployment pattern and copy it to the `<puppet_environment>/modules/apim_common/files/packs` directory in the **Puppetmaster**.

2. Set up the JDK distribution as follows:

   The Puppet modules for WSO2 products use Amazon Coretto as the JDK distribution. However, you can use any [supported JDK distribution](https://docs.wso2.com/display/compatibility/Tested+Operating+Systems+and+JDKs).
   1. Download Amazon Coretto for Linux x64 from [here](https://docs.aws.amazon.com/corretto/latest/corretto-8-ug/downloads-list.html) and copy .tar into the `<puppet_environment>/modules/apim_common/files/jdk` directory.
   2. Reassign the *$jdk_name* variable in `<puppet_environment>/modules/apim_common/manifests/params.pp` to the name of the downloaded JDK distribution.
5. Run the relevant profile on the **Puppet agent**.
    1. Default profile:
        ```bash
        export FACTER_profile=apim
        puppet agent -vt
        ```
    2. Gateway profile:
       ```bash
       export FACTER_profile=apim_gateway
       puppet agent -vt
       ```
    3. Key Manager profile:
       ```bash
       export FACTER_profile=apim_km
       puppet agent -vt
       ```
    4. Publisher profile:
       ```bash
       export FACTER_profile=apim_publisher
       puppet agent -vt
       ```
    5. Store profile:
       ```bash
       export FACTER_profile=apim_store
       puppet agent -vt
       ```
    6. Traffic Manager profile:
       ```bash
       export FACTER_profile=apim_tm
       puppet agent -vt
       ```
    7. Analytics profile:
        2. Worker:
            ```bash
            export FACTER_profile=apim_analytics_worker
            puppet agent -vt
            ```

## Manifests in a module
The run stages for Puppet are described in `<puppet_environment>/manifests/site.pp`, and they are of the order Main -> Custom.

Each Puppet module contains the following .pp files.
* Main
    * params.pp: Contains all the parameters necessary for the main configuration and template.
    * init.pp: Contains the main script of the module.
* Custom
    * custom.pp: Used to add custom configurations to the Puppet module.
    