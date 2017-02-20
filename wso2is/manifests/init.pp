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

# Manages WSO2 Identity Server deployment
class wso2is (
  # wso2is specific configuration data
  $am_datasources           = $wso2is::params::am_datasources,
  $bps_datasources          = $wso2is::params::bps_datasources,
  $metrics_datasources      = $wso2is::params::metrics_datasources,
  $is_datasource            = $wso2is::params::is_datasource,
  $sso_service_providers    = $wso2is::params::sso_service_providers,
  $enable_thrift_service    = $wso2is::params::enable_thrift_service,

  $packages               = $wso2is::params::packages,
  $template_list          = $wso2is::params::template_list,
  $file_list              = $wso2is::params::file_list,
  $patch_list             = $wso2is::params::patch_list,
  $cert_list              = $wso2is::params::cert_list,
  $system_file_list       = $wso2is::params::system_file_list,
  $directory_list         = $wso2is::params::directory_list,
  $hosts_mapping          = $wso2is::params::hosts_mapping,
  $java_home              = $wso2is::params::java_home,
  $java_prefs_system_root = $wso2is::params::java_prefs_system_root,
  $java_prefs_user_root   = $wso2is::params::java_prefs_user_root,
  $vm_type                = $wso2is::params::vm_type,
  $wso2_user              = $wso2is::params::wso2_user,
  $wso2_group             = $wso2is::params::wso2_group,
  $product_name           = $wso2is::params::product_name,
  $product_version        = $wso2is::params::product_version,
  $platform_version       = $wso2is::params::platform_version,
  $carbon_home_symlink    = $wso2is::params::carbon_home_symlink,
  $remote_file_url        = $wso2is::params::remote_file_url,
  $maintenance_mode       = $wso2is::params::maintenance_mode,
  $install_mode           = $wso2is::params::install_mode,
  $install_dir            = $wso2is::params::install_dir,
  $pack_dir               = $wso2is::params::pack_dir,
  $pack_filename          = $wso2is::params::pack_filename,
  $pack_extracted_dir     = $wso2is::params::pack_extracted_dir,
  $patches_dir            = $wso2is::params::patches_dir,
  $service_name           = $wso2is::params::service_name,
  $service_template       = $wso2is::params::service_template,
  $ipaddress              = $wso2is::params::ipaddress,
  $enable_secure_vault    = $wso2is::params::enable_secure_vault,
  $secure_vault_configs   = $wso2is::params::secure_vault_configs,
  $key_stores             = $wso2is::params::key_stores,
  $carbon_home            = $wso2is::params::carbon_home,
  $pack_file_abs_path     = $wso2is::params::pack_file_abs_path,

  # Templated configuration parameters
  $master_datasources     = $wso2is::params::master_datasources,
  $registry_mounts        = $wso2is::params::registry_mounts,
  $hostname               = $wso2is::params::hostname,
  $mgt_hostname           = $wso2is::params::mgt_hostname,
  $worker_node            = $wso2is::params::worker_node,
  $usermgt_datasource     = $wso2is::params::usermgt_datasource,
  $local_reg_datasource   = $wso2is::params::local_reg_datasource,
  $clustering             = $wso2is::params::clustering,
  $dep_sync               = $wso2is::params::dep_sync,
  $ports                  = $wso2is::params::ports,
  $jvm                    = $wso2is::params::jvm,
  $fqdn                   = $wso2is::params::fqdn,
  $sso_authentication     = $wso2is::params::sso_authentication,
  $user_management        = $wso2is::params::user_management
) inherits wso2is::params {

  validate_hash($am_datasources)
  validate_hash($bps_datasources)
  validate_hash($metrics_datasources)
  validate_string($is_datasource)
  validate_bool($enable_thrift_service)
  if $sso_service_providers != undef {
    validate_hash($sso_service_providers)
  }

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

  class { '::wso2base':
    packages               => $packages,
    template_list          => $template_list,
    file_list              => $file_list,
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
  contain wso2is::configure
  contain wso2base::service

  Class['::wso2base'] -> Class['::wso2base::system']
  -> Class['::wso2base::clean'] -> Class['::wso2base::install']
  -> Class['::wso2is::configure'] ~> Class['::wso2base::service']
}