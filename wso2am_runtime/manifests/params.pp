#----------------------------------------------------------------------------
#  Copyright (c) 2016 WSO2, Inc. http://www.wso2.org
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

class wso2am_runtime::params {

  # Set facter variables
  $vm_type                    = $::vm_type
  $ipaddress                  = $::ipaddress
  $fqdn                       = $::fqdn

  # use_hieradata facter flags whether parameter lookup should be done via Hiera
  if $::use_hieradata == 'true' {

    $is_datasource            = hiera('wso2::is_datasource')
    $am_datasource            = hiera('wso2::am_datasource')
    $am_datasources           = hiera_hash('wso2::am_datasources')
    $apim_traffic_manager     = hiera_hash('wso2::apim_traffic_manager')
    $environments             = hiera_hash('wso2::environments')
    $apim_keymanager          = hiera_hash('wso2::apim_keymanager')
    $apim_store               = hiera_hash('wso2::apim_store')
    $apim_publisher           = hiera_hash('wso2::apim_publisher')
    $enable_advance_throttling = hiera('wso2::enable_advance_throttling')
    $enable_thrift_server      = hiera('wso2::enable_thrift_server')
    $thrift_server_host        = hiera('wso2::thrift_server_host')
    $key_validator_client_type = hiera('wso2::key_validator_client_type')
    $enable_data_publisher     = hiera('wso2::enable_data_publisher')
    $enable_block_condition    = hiera('wso2::enable_block_condition')
    $enable_jms_connection_details = hiera('wso2::enable_jms_connection_details')
    $disable_jms_event_parameters = hiera('wso2::disable_jms_event_parameters')
    $apply_publisher_specific_configurations = hiera('wso2::apply_publisher_specific_configurations')
    $apply_store_specific_configurations = hiera('wso2::apply_store_specific_configurations')
    $apply_gateway_specific_configurations = hiera('wso2::apply_gateway_specific_configurations')
    $analytics                 = hiera_hash('wso2::analytics')
    $enable_log_analyzer       = hiera('wso2::enable_log_analyzer')
    $product_profile           = hiera('wso2::product_profile')

    $install_java             = hiera('wso2base::java::install_java')
    $java_install_dir         = hiera('wso2base::java::java_install_dir')
    $java_source_file         = hiera('wso2base::java::java_source_file')
    $java_user                = hiera('wso2base::java::wso2_user')
    $java_group               = hiera('wso2base::java::wso2_group')
    $java_prefs_system_root   = hiera('wso2base::java::prefs_system_root')
    $java_prefs_user_root     = hiera('wso2base::java::prefs_user_root')
    $java_home                = hiera('wso2base::java::java_home')

    # system configuration data
    $packages                 = hiera_array('packages')
    $template_list            = hiera_array('wso2::template_list')
    $file_list                = hiera_array('wso2::file_list', undef)
    $remove_file_list         = hiera_array('wso2::remove_file_list', undef)
    $patch_list               = hiera('wso2::patch_list', undef)
    $system_file_list         = hiera_hash('wso2::system_file_list', undef)
    $directory_list           = hiera_array('wso2::directory_list', undef)
    $cert_list                = hiera_array('wso2::cert_list', undef)
    $hosts_mapping            = hiera_hash('wso2::hosts_mapping')
    $key_store                = hiera('wso2::key_store')
    $trust_store              = hiera('wso2::trust_store')

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
    $autostart_service        = hiera('wso2::autostart_service')
    $usermgt_datasource       = hiera('wso2::usermgt_datasource')
    $local_reg_datasource     = hiera('wso2::local_reg_datasource')
    $clustering               = hiera('wso2::clustering')
    $dep_sync                 = hiera('wso2::dep_sync')
    $ports                    = hiera('wso2::ports')
    $jvm                      = hiera('wso2::jvm')
    $sso_authentication       = hiera('wso2::sso_authentication')
    $user_management          = hiera('wso2::user_management')
    $enable_secure_vault      = hiera('wso2::enable_secure_vault')
    $mb_store_datasource      = hiera('wso2::mb_store_datasource')

    if $enable_secure_vault {
      $secure_vault_configs   = hiera('wso2::secure_vault_configs')
    }

    $key_stores               = hiera('wso2::key_stores')

  } else {

    $is_datasource            = 'wso2_am_db'
    $am_datasource            = 'wso2_am_db'

    $am_datasources           = {
      wso2_am_db => {
        name                 => 'WSO2_AM_DB',
        description          => 'The datasource used for API Manager database',
        driver_class_name    => "org.h2.Driver",
        url                  => 'jdbc:h2:repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE',
        username             => 'wso2carbon',
        password             => 'wso2carbon',
        jndi_config          => 'jdbc/WSO2AM_DB',
        max_active           => '50',
        max_wait             => '60000',
        test_on_borrow       => true,
        default_auto_commit  => false,
        validation_query     => 'SELECT 1',
        validation_interval  => '30000'
      }
    }

    $apim_traffic_manager     ={
      host                 => 'localhost',
      port                 => '9443',
      receiver_url_port    => '9611',
      auth_url_port        => '9711',
      jms_url_port         => '5672',
      username             => 'admin',
      password             => 'admin'

    }

    $environments           = {
        apim_gateway  => {
          host                                  => 'localhost',
          port                                  => '9443',
          api_endpoint_host                     => 'localhost',
          api_endpoint_port                     => '8280',
          secure_api_endpoint_port              => '8243',
          api_token_revoke_endpoint_port        => '8280',
          secure_api_token_revoke_endpoint_port => '8243',
          username                              => 'admin',
          password                              => 'admin'
        }
    }

    $apim_keymanager          ={
      host     => 'localhost',
      port     => '9443',
      username => 'admin',
      password => 'admin'
    }

    $apim_store               ={
      host => 'localhost',
      port => '9443'
    }

    $apim_publisher           ={
      host => 'localhost',
      port => '9443'
    }

    $enable_advance_throttling = false
    $enable_thrift_server      = true
    $thrift_server_host        = 'localhost'
    $key_validator_client_type = 'ThriftClient'
    $enable_data_publisher     = false
    $enable_block_condition    = true
    $enable_jms_connection_details = false
    $disable_jms_event_parameters = false
    $apply_publisher_specific_configurations = false
    $apply_store_specific_configurations = false
    $apply_gateway_specific_configurations = false
    $enable_log_analyzer      = false

    $install_java             = 'true'
    $java_install_dir         = '/mnt/jdk-8u131'
    $java_source_file         = 'jdk-8u131-linux-x64.tar.gz'
    $java_user                = 'wso2user'
    $java_group               = 'wso2'

    $java_prefs_system_root   = '/home/wso2user/.java'
    $java_prefs_user_root     = '/home/wso2user/.java/.systemPrefs'
    $java_home                = '/opt/java'

    # system configuration data
    $packages                 = [
      'zip',
      'unzip'
    ]

    $template_list        = [
      'repository/conf/carbon.xml',
      'repository/conf/user-mgt.xml',
      'repository/conf/registry.xml',
      'repository/conf/datasources/master-datasources.xml',
      'repository/conf/tomcat/catalina-server.xml',
      'repository/conf/axis2/axis2.xml',
      'repository/conf/security/authenticators.xml',
      'bin/wso2server.sh',
      'repository/conf/datasources/am-datasources.xml',
      'repository/conf/api-manager.xml',
      'repository/conf/identity/identity.xml',
      'repository/conf/identity/application-authentication.xml',
      'repository/conf/identity/EndpointConfig.properties',
      'repository/conf/broker.xml'
    ]

    $hosts_mapping            = {
      localhost => {
        ip   => '127.0.0.1',
        name => 'localhost'
      }
    }

    $master_datasources       = {
      wso2_carbon_db   => {
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
      },
      wso2_mb_store_db => {
        name                => 'WSO2_MB_STORE_DB',
        description         => 'The datasource used for message broker database',
        driver_class_name   => 'org.h2.Driver',
        url                 => 'jdbc:h2:repository/database/WSO2MB_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
        username            => 'wso2carbon',
        password            => 'wso2carbon',
        jndi_config         => 'WSO2MBStoreDB',
        max_active          => '50',
        max_wait            => '60000',
        test_on_borrow      => true,
        default_auto_commit => false,
        validation_query    => 'SELECT 1',
        validation_interval => '30000',
      }
    }

    $carbon_home_symlink      = "/mnt/wso2am-${product_version}"
    $wso2_user                = 'wso2user'
    $wso2_group               = 'wso2'
    $maintenance_mode         = 'refresh'
    $install_mode             = 'file_bucket'
    $install_dir              = "/mnt"
    $pack_dir                 = '/mnt/packs'
    $pack_filename            = "wso2am-${product_version}.zip"
    $pack_extracted_dir       = "wso2am-${product_version}"
    $hostname                 = 'localhost'
    $mgt_hostname             = 'localhost'
    $worker_node              = false
    $patches_dir              = 'repository/components/patches'
    $service_name             = wso2am
    $service_template         = 'wso2base/wso2service.erb'
    $autostart_service        = 'true'
    $usermgt_datasource       = 'wso2_carbon_db'
    $local_reg_datasource     = 'wso2_carbon_db'
    $mb_store_datasource      = 'wso2_mb_store_db'

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
    $analytics                  =    {
        enabled             => false,
        server_host         => 'localhost',
        server_port         => '7612',
        server_https_port   => '9444',
        server_username     => '${admin.username}',
        server_password     => '${admin.password}',
        skip_event_receiver_connection => false
    }
  }

  $product_name               = 'wso2am'
  $product_version            = '2.1.0'
  $platform_version           = '4.4.0'
  $carbon_home                = "${install_dir}/${product_name}-${product_version}"
  $pack_file_abs_path         = "${pack_dir}/${pack_filename}"
}
