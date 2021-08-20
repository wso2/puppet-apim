# Customize WSO2 Puppet resources to deploy API Manager Pattern 1

This document provides instructions to customize the WSO2 API Manager Puppet resources in order to deploy API Manager Pattern 1.

![API Manager Pattern 1](images/Pattern-1.png "API Manager Pattern 1")

## Copy the pack and JDK

Copy the JDK and the product pack as mentioned in the [Quick start guide](../README.md).

> NOTE: Make sure you include any third-party dependencies required to the downloaded product pack. 

## Customize the WSO2 Puppet scripts

The following is the module needed to deploy API Manager pattern 1.

- apim

API Manager pattern 1 contains 1 profile and the configurations specific for each profile should be in the respective `params.pp` files in the `<puppet_environment>/modules/<profile>/manifests` directory.

> NOTE: Moreover, the common configurations for all the profiles are included in the `params.pp` file in the `<puppet_environment>/modules/apim_comon/manifests` directory.

### Customize `apim` module

Navigate to [carbon-home](../modules/apim/templates/carbon-home) of the `apim` module. All the files required to deploy the API Manager active-active combination are here. Follow the instructions in the following document to modify the files.
- [Configuring an active-active deployment](https://apim.docs.wso2.com/en/latest/install-and-setup/setup/single-node/configuring-an-active-active-deployment/)

