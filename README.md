# WSO2 API Manager 2.5.0 Puppet 5 Modules

This repository contains puppet modules for each profile relates to API Manager.

## Quick Start Guide
1. Download and copy the `wso2am-linux-installer-x64-2.5.0.deb` or/and `wso2am-linux-installer-x64-2.5.0.rpm` to the files directories in `/etc/puppet/code/environments/dev/modules/__profile__/files` in the Puppetmaster. <br>
Profile refers to each profile in API Manager <br>
eg: `/etc/puppet/code/environments/dev/modules/apim/files` <br>
Dev refers to the sample environment that you can try this modules.

2. Run necessary profile on puppet agent. More details on this is available in following section.

## Running API Manager Profiles in Puppet Agent
This section describes how to run each profile in puppet agent. To find out more details about each profile refer [API Manager Documentation - Product Profiles](https://docs.wso2.com/display/AM250/Product+Profiles).

### Default profile
```bash
export FACTER_profile=apim
puppet agent -vt
```

### Gateway worker profile
```bash
export FACTER_profile=apim_gateway
puppet agent -vt
```

### Key manager profile
```bash
export FACTER_profile=apim_km
puppet agent -vt
```

### Traffice manager profile
```bash
export FACTER_profile=apim_tm
puppet agent -vt
```

### API publisher profile
```bash
export FACTER_profile=apim_publisher
puppet agent -vt
```

### API store profile
```bash
export FACTER_profile=apim_store
puppet agent -vt
```

## Understanding the Project Structure
In this project each profle of API Manager is mapped to a module in puppet. By having this structure each puppet module is considered as a standalone profile so each module can be configured individually without harming any other module.

```tree
puppet-apim
├── manifests
│   └── site.pp
└── modules
    ├── apim
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ... 
    ├── apim_gateway
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    ├── apim_km
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    ├── apim_publisher
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    ├── apim_store
    │   ├── files
    │   │   └── ...
    │   ├── manifests
    │   │   ├── init.pp
    │   │   ├── custom.pp
    │   │   ├── params.pp
    │   │   └── startserver.pp
    │   └── templates
    │       └── ...
    └── apim_tm
        ├── files
        │   └── ...
        ├── manifests
        │   ├── init.pp
        │   ├── custom.pp
        │   ├── params.pp
        │   └── startserver.pp
        └── templates
            └── ...

```

### Manifests in a module
Each puppet module contains following pp files
- init.pp <br>
This contains the main script of the module.
- custom.pp <br>
This is used to add custom user code to the profile.
- params.pp <br>
This contains all necessary parameters for main configurations and template rendering.
- startserver.pp <br>
This runs finally and starts the server as a service.
