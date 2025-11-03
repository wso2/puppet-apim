# ----------------------------------------------------------------------------
#  Copyright (c) 2021 WSO2, Inc. http://www.wso2.org
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

# Class: apim_km
# Init class of API Manager - Key Manager profile
class apim_km inherits apim_km::params {

  include apim_common

  # Run profile setup before starting the service
  exec { 'setup-key-manager-profile':
    command => "sh ${carbon_home}/bin/profileSetup.sh -Dprofile=key-manager",
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    user    => $user,
    group   => $user_group,
    cwd     => $carbon_home,
    onlyif  => "test ! -f ${carbon_home}/.km_profile_setup_complete",
    creates => "${carbon_home}/.km_profile_setup_complete",
    require => [
      Exec['rename-km-dir'],
      User[$user]
    ],
    notify  => Service[$wso2_service_name],
  }

  # Create marker file after profile setup
  file { "${carbon_home}/.km_profile_setup_complete":
    ensure  => present,
    owner   => $user,
    group   => $user_group,
    mode    => '0644',
    require => Exec['setup-key-manager-profile'],
  }

  # Copy configuration changes to the installed directory
  $template_list.each |String $template| {
    file { "${carbon_home}/${template}":
      ensure  => file,
      mode    => '0644',
      content => template("${module_name}/carbon-home/${template}.erb"),
      notify  => Service["${wso2_service_name}"],
      require => Class["apim_common"]
    }
  }

  # Copy files to carbon home directory
  $file_list.each | String $file | {
    file { "${carbon_home}/${file}":
      ensure => present,
      owner => $user,
      recurse => remote,
      group => $user_group,
      mode => '0755',
      source => "puppet:///modules/${module_name}/${file}",
      notify  => Service["${wso2_service_name}"],
      require => Class["apim_common"]
    }
  }

  # Delete files from carbon home directory
  $file_removelist.each | String $removefile | {
    file { "${carbon_home}/${removefile}":
      ensure => absent,
      owner => $user,
      group => $user_group,
      notify  => Service["${wso2_service_name}"],
      require => Class["apim_common"]
    }
  }

  # Copy key-manager.sh to installed directory
  file { "${carbon_home}/${start_script_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
    content => template("${module_name}/carbon-home/${start_script_template}.erb"),
    notify  => Service["${wso2_service_name}"],
    require => Class["apim_common"]
  }

  /*
    Following script can be used to copy file to a given location.
    This will copy some_file to install_path -> repository.
    Note: Ensure that file is available in modules -> apim_km -> files
  */
  # file { "${install_path}/repository/some_file":
  #   owner  => $user,
  #   group  => $user_group,
  #   mode   => '0644',
  #   source => "puppet:///modules/${module_name}/some_file",
  # }
}
