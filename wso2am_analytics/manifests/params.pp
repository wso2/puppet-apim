#----------------------------------------------------------------------------
#  Copyright (c) 2017 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#----------------------------------------------------------------------------

class wso2am_analytics::params {

  # Set facter variables
  $vm_type                    = $::vm_type
  $ipaddress                  = $::ipaddress
  $fqdn                       = $::fqdn

  # use_hieradata facter flags whether parameter lookup should be done via Hiera
  if $::use_hieradata == 'true' {

    $analytics_datasources    = hiera('wso2::analytics_datasources')
    $stats_datasources        = hiera('wso2::stats_datasources')
    #$metrics_datasources      = hiera('wso2::metrics_datasources')
    $spark                    = hiera('wso2::spark')
    $is_datasource            = hiera('wso2::is_datasource', undef)
    $single_node_deployment   = hiera('wso2::single_node_deployment')
    #$ha_deployment            = hiera('wso2::ha_deployment')
    $portal                   = hiera('wso2::portal')
    $type_mapping_string_type_mysql = hiera('wso2::type_mapping_string_type_mysql')

    $java_prefs_system_root   = hiera('java_prefs_system_root')
    $java_prefs_user_root     = hiera('java_prefs_user_root')
    $java_home                = hiera('java_home')

    # system configuration data
    $packages                 = hiera_array('packages')
    $template_list            = hiera_array('wso2::template_list')
    $file_list                = hiera_array('wso2::file_list', undef)
    $patch_list               = hiera('wso2::patch_list', undef)
    $system_file_list         = hiera_hash('wso2::system_file_list', undef)
    $directory_list           = hiera_array('wso2::directory_list', undef)
    $cert_list                = hiera_hash('wso2::cert_list', undef)
    $hosts_mapping            = hiera_hash('wso2::hosts_mapping')

    $master_datasources       = hiera_hash('wso2::master_datasources')
    $registry_mounts          = hiera_hash('wso2::registry_mounts', undef)
    $carbon_home_symlink      = hiera('wso2::carbon_home_symlink')
    $wso2_user                = hiera('wso2::user')
    $wso2_group               = hiera('wso2::group')
    $maintenance_mode         = hiera('wso2::maintenance_mode')
    $install_mode             = hiera('wso2::install_mode')

    if $install_mode == 'file_repo' {
      $remote_file_url        = hiera('remote_file_url')
    }

    $install_dir              = hiera('wso2::install_dir')
    $pack_dir                 = hiera('wso2::pack_dir')
    $pack_filename            = hiera('wso2::pack_filename')
    $pack_extracted_dir       = hiera('wso2::pack_extracted_dir')
    $hostname                 = hiera('wso2::hostname')
    $mgt_hostname             = hiera('wso2::mgt_hostname')
    $worker_node              = hiera('wso2::worker_node')
    $patches_dir              = hiera('wso2::patches_dir')
    $service_name             = hiera('wso2::service_name')
    $service_template         = hiera('wso2::service_template')
    $usermgt_datasource       = hiera('wso2::usermgt_datasource')
    $local_reg_datasource     = hiera('wso2::local_reg_datasource')
    $clustering               = hiera('wso2::clustering')
    $dep_sync                 = hiera('wso2::dep_sync')
    $ports                    = hiera('wso2::ports')
    $jvm                      = hiera('wso2::jvm')
    $sso_authentication       = hiera('wso2::sso_authentication')
    $user_management          = hiera('wso2::user_management')
    $enable_secure_vault      = hiera('wso2::enable_secure_vault')

    $key_stores               = hiera('wso2::key_stores')

  } else {


    $analytics_datasources     = {
      wso2_analytics_fs_db      => {
        name                => 'WSO2_ANALYTICS_FS_DB',
        description         => 'The datasource used for analytics file system',
        driver_class_name   => 'org.h2.Driver',
        url                 => 'jdbc:h2:repository/database/ANALYTICS_FS_DB;AUTO_SERVER=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
        username            => 'wso2carbon',
        password            => 'wso2carbon',
        max_active          => '50',
        max_wait            => '60000',
        test_on_borrow      => true,
        default_auto_commit => false,
        validation_query    => 'SELECT 1',
        validation_interval => '30000',
        initial_size        => 0,
        test_while_idle     => true,
        min_evictable_idle_time_millis  => 4000
      },
      wso2_analytics_event_store_db     => {
        name                => 'WSO2_ANALYTICS_EVENT_STORE_DB',
        description         => 'The datasource used for analytics record store',
        driver_class_name   => 'org.h2.Driver',
        url                 => 'jdbc:h2:repository/database/ANALYTICS_EVENT_STORE;AUTO_SERVER=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
        username            => 'wso2carbon',
        password            => 'wso2carbon',
        max_active          => '50',
        max_wait            => '60000',
        test_on_borrow      => true,
        default_auto_commit => false,
        validation_query    => 'SELECT 1',
        validation_interval => '30000',
        initial_size        => 0,
        test_while_idle     => true,
        min_evictable_idle_time_millis  => 4000
      },
      wso2_analytics_processed_data_store_db => {
        name                => 'WSO2_ANALYTICS_PROCESSED_DATA_STORE_DB',
        description         => 'The datasource used for analytics record store',
        driver_class_name   => 'org.h2.Driver',
        url                 => 'jdbc:h2:repository/database/ANALYTICS_PROCESSED_DATA_STORE;AUTO_SERVER=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
        username            => 'wso2carbon',
        password            => 'wso2carbon',
        max_active          => '50',
        max_wait            => '60000',
        test_on_borrow      => true,
        default_auto_commit => false,
        validation_query    => 'SELECT 1',
        validation_interval => '30000',
        initial_size        => 0,
        test_while_idle     => true,
        min_evictable_idle_time_millis  => 4000
      }
    }

    $metrics_datasources       = {
      wso2_metrics_db   => {
        name                => 'WSO2_METRICS_DB',
        description         => 'The default datasource used for WSO2 Carbon Metrics',
        driver_class_name   => 'org.h2.Driver',
        url                 => 'jdbc:h2:repository/database/WSO2METRICS_DB;DB_CLOSE_ON_EXIT=FALSE;AUTO_SERVER=TRUE',
        username            => 'wso2carbon',
        password            => 'wso2carbon',
        jndi_config         => 'jdbc/WSO2MetricsDB',
        datasource          => 'WSO2MetricsDB',
        max_active          => '50',
        max_wait            => '60000',
        test_on_borrow      => true,
        default_auto_commit => false,
        validation_query    => 'SELECT 1',
        validation_interval => '30000'
      }
    }

    $stats_datasources       = {
      wso2_am_stats_db   => {
        name                => 'WSO2AM_STATS_DB',
        description         => 'The datasource used for setting statistics to API Manager',
        driver_class_name   => 'org.h2.Driver',
        url                 => 'jdbc:h2:../tmpStatDB/WSO2AM_STATS_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;AUTO_SERVER=TRUE',
        username            => 'wso2carbon',
        password            => 'wso2carbon',
        jndi_config         => 'jdbc/WSO2AM_STATS_DB',
        max_active          => '50',
        max_wait            => '60000',
        test_on_borrow      => true,
        default_auto_commit => false,
        validation_query    => 'SELECT 1',
        validation_interval => '30000'
       }
    }

    $spark      = {
      master        => 'local',
      master_count  => '1',
      hostname      => $ipaddress
    }

    $is_datasource   = 'wso2_carbon_db'

    $single_node_deployment = {
      enabled  => true
    }

    $ha_deployment   = {
      enabled           => false,
      presenter_enabled => false,
      worker_enabled    => true,
      eventSync         => {
        hostName  => $ipaddress,
        port      => 11224
      },
      management        => {
        hostName  => $ipaddress,
        port      => 10005
      },
      presentation      => {
        hostName  => $ipaddress,
        port      => 11000
      }
    }

    $portal   = {
      hostname   => 'das.dev.wso2.org'
    }

    $directory_list             = [
      'dbscripts/identity'
    ]

    $java_prefs_system_root   = '/home/wso2user/.java'
    $java_prefs_user_root     = '/home/wso2user/.java/.systemPrefs'
    $java_home                = '/opt/java'

    # system configuration data
    $packages             = [
      'zip',
      'unzip'
    ]

    $template_list        = [
      'repository/conf/identity/identity.xml',
      'repository/conf/datasources/analytics-datasources.xml',
      'repository/conf/carbon.xml',
      'repository/conf/user-mgt.xml',
      'repository/conf/registry.xml',
      'repository/conf/datasources/master-datasources.xml',
      'repository/conf/tomcat/catalina-server.xml',
      'repository/conf/axis2/axis2.xml',
      'repository/conf/security/authenticators.xml',
      'bin/wso2server.sh'
    ]

    $hosts_mapping            = {
      localhost => {
        ip   => '127.0.0.1',
        name => 'localhost'
      }
    }

    $master_datasources       = {
      wso2_carbon_db => {
        name                => 'WSO2_CARBON_DB',
        description         => 'The datasource used for registry and user manager',
        driver_class_name   => 'org.h2.Driver',
        url                 => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
        username            => 'wso2carbon',
        password            => 'wso2carbon',
        jndi_config         => 'jdbc/WSO2CarbonDB',
        max_active          => '50',
        max_wait            => '60000',
        test_on_borrow      => true,
        default_auto_commit => false,
        validation_query    => 'SELECT 1',
        validation_interval => '30000'
      }
    }

    $carbon_home_symlink      = "/mnt/${product_name}-${product_version}"
    $wso2_user                = 'wso2user'
    $wso2_group               = 'wso2'
    $maintenance_mode         = 'refresh'
    $install_mode             = 'file_bucket'
    $install_dir              = "/mnt"
    $pack_dir                 = '/mnt/packs'
    $pack_filename            = "wso2am-analytics-${product_version}.zip"
    $pack_extracted_dir       = "wso2am-analytics-${product_version}"
    $hostname                 = 'localhost'
    $mgt_hostname             = 'localhost'
    $worker_node              = false
    $patches_dir              = 'repository/components/patches'
    $service_name             = $product_name
    $service_template         = 'wso2base/wso2service.erb'
    $usermgt_datasource       = 'wso2_carbon_db'
    $local_reg_datasource     = 'wso2_carbon_db'

    $clustering               = {
      enabled           => false,
      membership_scheme => 'wka',
      domain            => 'wso2.carbon.domain',
      local_member_host => '127.0.0.1',
      local_member_port => '4000',
      sub_domain        => 'mgt',
      wka               => {
        members => [
          {
            hostname => '127.0.0.1',
            port     => 4000
          }
        ]
      }
    }

    $dep_sync                 = {
      enabled => false
    }

    $ports                    = {
      offset => 0
    }

    $jvm                      = {
      xms           => '256m',
      xmx           => '1024m',
      max_perm_size => '256m'
    }

    $sso_authentication       = {
      enabled => false
    }

    $user_management          = {
      admin_role      => 'admin',
      admin_username  => 'admin',
      admin_password  => 'admin'
    }

    $enable_secure_vault      = false

    $key_stores               = {
      key_store              => {
        location     => 'repository/resources/security/wso2carbon.jks',
        type         => 'JKS',
        password     => 'wso2carbon',
        key_alias    => 'wso2carbon',
        key_password => 'wso2carbon'
      },
      registry_key_store     => {
        location     => 'repository/resources/security/wso2carbon.jks',
        type         => 'JKS',
        password     => 'wso2carbon',
        key_alias    => 'wso2carbon',
        key_password => 'wso2carbon'
      },
      trust_store            => {
        location => 'repository/resources/security/client-truststore.jks',
        type     => 'JKS',
        password => 'wso2carbon'
      },
      connector_key_store    => {
        location => 'repository/resources/security/wso2carbon.jks',
        password => 'wso2carbon'
      },
      user_trusted_rp_store  => {
        location     => 'repository/resources/security/userRP.jks',
        type         => 'JKS',
        password     => 'wso2carbon',
        key_password => 'wso2carbon'
      }
    }
    $type_mapping_string_type_mysql = 'VARCHAR(254)'

  }

  $product_name               = 'wso2am-analytics'
  $product_version            = '2.1.0'
  $platform_version           = '4.4.0'
  $carbon_home                = "${install_dir}/${product_name}-${product_version}"
  $pack_file_abs_path         = "${pack_dir}/${pack_filename}"
}
