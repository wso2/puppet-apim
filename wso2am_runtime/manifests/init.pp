# ------------------------------------------------------------------------------
# Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ------------------------------------------------------------------------------

# Manages WSO2 API Manager deployment
class wso2am_runtime (
  # wso2am_runtime specific configuration data
  $is_datasource          = $wso2am_runtime::params::is_datasource,
  $am_datasource          = $wso2am_runtime::params::am_datasource,
  $am_datasources           = $wso2am_runtime::params::am_datasources,
  $service_name             = $wso2am_runtime::params::service_name,
  $hostname                 = $wso2am_runtime::params::hostname,
  $mgt_hostname             = $wso2am_runtime::params::mgt_hostname,
  $apim_traffic_manager     = $wso2am_runtime::params::apim_traffic_manager,
  $environments             = $wso2am_runtime::params::environments,
  $apim_keymanager          = $wso2am_runtime::params::apim_keymanager,
  $apim_store               = $wso2am_runtime::params::apim_store,
  $apim_publisher           = $wso2am_runtime::params::apim_publisher,
  $enable_advance_throttling = $wso2am_runtime::params::enable_advance_throttling,
  $enable_thrift_server      = $wso2am_runtime::params::enable_thrift_server,
  $thrift_server_host        = $wso2am_runtime::params::thrift_server_host,
  $key_validator_client_type = $wso2am_runtime::params::key_validator_client_type,
  $enable_data_publisher     = $wso2am_runtime::params::enable_data_publisher,
  $enable_block_condition    = $wso2am_runtime::params::enable_block_condition,
  $enable_jms_connection_details = $wso2am_runtime::params::enable_jms_connection_details,
  $disable_jms_event_parameters = $wso2am_runtime::params::disable_jms_event_parameters,
  $apply_publisher_specific_configurations = $wso2am_runtime::params::apply_publisher_specific_configurations,
  $apply_store_specific_configurations = $wso2am_runtime::params::apply_store_specific_configurations,
  $apply_gateway_specific_configurations = $wso2am_runtime::params::apply_gateway_specific_configurations,
  $analytics                 = $wso2am_runtime::params::analytics,
  $enable_log_analyzer       = $wso2am_runtime::params::enable_log_analyzer,
  $product_profile           = $wso2am_runtime::params::product_profile,

  $packages               = $wso2am_runtime::params::packages,
  $template_list          = $wso2am_runtime::params::template_list,
  $file_list              = $wso2am_runtime::params::file_list,
  $patch_list             = $wso2am_runtime::params::patch_list,
  $cert_list              = $wso2am_runtime::params::cert_list,
  $system_file_list       = $wso2am_runtime::params::system_file_list,
  $directory_list         = $wso2am_runtime::params::directory_list,
  $hosts_mapping          = $wso2am_runtime::params::hosts_mapping,
  $java_home              = $wso2am_runtime::params::java_home,
  $java_prefs_system_root = $wso2am_runtime::params::java_prefs_system_root,
  $java_prefs_user_root   = $wso2am_runtime::params::java_prefs_user_root,
  $vm_type                = $wso2am_runtime::params::vm_type,
  $wso2_user              = $wso2am_runtime::params::wso2_user,
  $wso2_group             = $wso2am_runtime::params::wso2_group,
  $product_name           = $wso2am_runtime::params::product_name,
  $product_version        = $wso2am_runtime::params::product_version,
  $platform_version       = $wso2am_runtime::params::platform_version,
  $carbon_home_symlink    = $wso2am_runtime::params::carbon_home_symlink,
  $remote_file_url        = $wso2am_runtime::params::remote_file_url,
  $maintenance_mode       = $wso2am_runtime::params::maintenance_mode,
  $install_mode           = $wso2am_runtime::params::install_mode,
  $install_dir            = $wso2am_runtime::params::install_dir,
  $pack_dir               = $wso2am_runtime::params::pack_dir,
  $pack_filename          = $wso2am_runtime::params::pack_filename,
  $pack_extracted_dir     = $wso2am_runtime::params::pack_extracted_dir,
  $patches_dir            = $wso2am_runtime::params::patches_dir,
  $service_name           = $wso2am_runtime::params::service_name,
  $service_template       = $wso2am_runtime::params::service_template,
  $ipaddress              = $wso2am_runtime::params::ipaddress,
  $enable_secure_vault    = $wso2am_runtime::params::enable_secure_vault,
  $secure_vault_configs   = $wso2am_runtime::params::secure_vault_configs,
  $key_stores             = $wso2am_runtime::params::key_stores,
  $carbon_home            = $wso2am_runtime::params::carbon_home,
  $pack_file_abs_path     = $wso2am_runtime::params::pack_file_abs_path,
  $remove_file_list       = $wso2am_runtime::params::remove_file_list,
  $key_store              = $wso2am_runtime::params::key_store,
  $trust_store            = $wso2am_runtime::params::trust_store,

  # Templated configuration parameters
  $master_datasources     = $wso2am_runtime::params::master_datasources,
  $registry_mounts        = $wso2am_runtime::params::registry_mounts,
  $hostname               = $wso2am_runtime::params::hostname,
  $mgt_hostname           = $wso2am_runtime::params::mgt_hostname,
  $worker_node            = $wso2am_runtime::params::worker_node,
  $usermgt_datasource     = $wso2am_runtime::params::usermgt_datasource,
  $local_reg_datasource   = $wso2am_runtime::params::local_reg_datasource,
  $clustering             = $wso2am_runtime::params::clustering,
  $dep_sync               = $wso2am_runtime::params::dep_sync,
  $ports                  = $wso2am_runtime::params::ports,
  $jvm                    = $wso2am_runtime::params::jvm,
  $fqdn                   = $wso2am_runtime::params::fqdn,
  $sso_authentication     = $wso2am_runtime::params::sso_authentication,
  $user_management        = $wso2am_runtime::params::user_management,
  $mb_store_datasource    = $wso2am_runtime::params::mb_store_datasource
) inherits wso2am_runtime::params {

  validate_string($is_datasource)

  validate_hash($master_datasources)
  if $registry_mounts != undef {
    validate_hash($registry_mounts)
  }
  validate_string($hostname)
  validate_string($mgt_hostname)
  validate_bool($worker_node)
  validate_string($usermgt_datasource)
  validate_string($local_reg_datasource)
  validate_hash($clustering)
  validate_hash($dep_sync)
  validate_hash($ports)
  validate_hash($jvm)
  validate_string($fqdn)
  validate_hash($sso_authentication)
  validate_hash($user_management)
  validate_string($mb_store_datasource)
  validate_bool($apply_publisher_specific_configurations)
  validate_bool($apply_store_specific_configurations)
  validate_bool($apply_gateway_specific_configurations)
  validate_hash($analytics)
  validate_bool($enable_log_analyzer)
  validate_string($key_store)
  validate_string($trust_store)

  class { '::wso2base':
    packages               => $packages,
    template_list          => $template_list,
    file_list              => $file_list,
    remove_file_list       => $remove_file_list,
    patch_list             => $patch_list,
    cert_list              => $cert_list,
    system_file_list       => $system_file_list,
    directory_list         => $directory_list,
    hosts_mapping          => $hosts_mapping,
    java_home              => $java_home,
    java_prefs_system_root => $java_prefs_system_root,
    java_prefs_user_root   => $java_prefs_user_root,
    vm_type                => $vm_type,
    wso2_user              => $wso2_user,
    wso2_group             => $wso2_group,
    product_name           => $product_name,
    product_version        => $product_version,
    platform_version       => $platform_version,
    carbon_home_symlink    => $carbon_home_symlink,
    remote_file_url        => $remote_file_url,
    maintenance_mode       => $maintenance_mode,
    install_mode           => $install_mode,
    install_dir            => $install_dir,
    pack_dir               => $pack_dir,
    pack_filename          => $pack_filename,
    pack_extracted_dir     => $pack_extracted_dir,
    patches_dir            => $patches_dir,
    service_name           => $service_name,
    service_template       => $service_template,
    ipaddress              => $ipaddress,
    enable_secure_vault    => $enable_secure_vault,
    secure_vault_configs   => $secure_vault_configs,
    key_stores             => $key_stores,
    carbon_home            => $carbon_home,
    pack_file_abs_path     => $pack_file_abs_path
  }

  contain wso2base
  contain wso2base::system
  contain wso2base::clean
  contain wso2base::install
  contain wso2base::configure
  contain wso2base::service

  Class['::wso2base'] -> Class['::wso2base::system']
  -> Class['::wso2base::clean'] -> Class['::wso2base::install']
  -> Class['::wso2base::configure'] ~> Class['::wso2base::service']
}