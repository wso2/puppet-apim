# ----------------------------------------------------------------------------
#  Copyright (c) 2018 WSO2, Inc. http://www.wso2.org
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
# ----------------------------------------------------------------------------

# Class: apim
# Init class of API Manager - Traffic Manager profile
class apim (
  $user                  = $apim_tm::params::user,
  $user_id               = $apim_tm::params::user_id,
  $user_group            = $apim_tm::params::user_group,
  $user_group_id         = $apim_tm::params::user_group_id,
  $service_name          = $apim_tm::params::service_name,
  $template_list         = $apim_tm::params::template_list,
  $jre_version           = $apim_tm::params::jre_version,
  $start_script_template = $apim_tm::params::start_script_template,

  # api-manager.xml configs
  $auth_manager          = $apim_tm::params::auth_manager,
  $api_gateway           = $apim_tm::params::api_gateway,
  $analytics             = $apim_tm::params::analytics,
  $api_store             = $apim_tm::params::api_store,
  $api_publisher         = $apim_tm::params::api_publisher,

  # Master-datasource configs
  $wso2am_db             = $apim_tm::params::wso2am_db,
  $wso2am_stat_db        = $apim_tm::params::wso2am_stat_db,
  $wso2_mb_store_db      = $apim_tm::params::wso2_mb_store_db,

  # carbon.xml configs
  $ports                 = $apim_tm::params::ports,
  $key_store             = $apim_tm::params::key_store,
)

  inherits apim_tm::params {

  if $::osfamily == 'redhat' {
    $apim_package = 'wso2am-linux-installer-x64-2.5.0.rpm'
    $installer_provider = 'rpm'
    $install_path = '/usr/lib64/wso2/wso2am/2.5.0'
  }
  elsif $::osfamily == 'debian' {
    $apim_package = 'wso2am-linux-installer-x64-2.5.0.deb'
    $installer_provider = 'dpkg'
    $install_path = '/usr/lib/wso2/wso2am/2.5.0'
  }

  # Create wso2 group
  group { $user_group:
    ensure => present,
    gid    => $user_group_id,
    system => true,
  }

  # Create wso2 user
  user { $user:
    ensure => present,
    uid    => $user_id,
    gid    => $user_group_id,
    home   => "/home/${user}",
    system => true,
  }
  # Ensure the installation directory is available
  file { "/opt/${service_name}":
    ensure => 'directory',
    owner  => $user,
    group  => $user_group,
  }

  # Copy the installer to the directory
  file { "/opt/${service_name}/${apim_package}":
    owner  => $user,
    group  => $user_group,
    mode   => '0644',
    source => "puppet:///modules/${module_name}/${apim_package}",
  }

  # Install WSO2 API Manager
  package { $service_name:
    ensure   => installed,
    provider => $installer_provider,
    source   => "/opt/${service_name}/${apim_package}"
  }

  # Change the ownership of the installation directory to wso2 user & group
  file { $install_path:
    ensure  => directory,
    owner   => $user,
    group   => $user_group,
    require => [ User[$user], Group[$user_group]],
    recurse => true
  }

  # Copy configuration changes to the installed directory
  $template_list.each | String $template | {
    file { "${install_path}/${template}":
      ensure  => file,
      owner   => $user,
      group   => $user_group,
      mode    => '0644',
      content => template("${module_name}/carbon-home/${template}.erb")
    }
  }

  # Copy wso2server.sh to installed directory
  file { "${install_path}/${start_script_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
    content => template("${module_name}/carbon-home/${start_script_template}.erb")
  }

  # Copy the unit file required to deploy the server as a service
  file { "/etc/systemd/system/${service_name}.service":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0754',
    content => template("${module_name}/${service_name}.service.erb"),
  }

  /*
    Following script can be used to copy file to a given location.
    This will copy some_file to install_path -> repository.
    Note: Ensure that file is available in modules -> apim -> files
  */
  # file { "${install_path}/repository/some_file":
  #   owner  => $user,
  #   group  => $user_group,
  #   mode   => '0644',
  #   source => "puppet:///modules/${module_name}/some_file",
  # }
}
