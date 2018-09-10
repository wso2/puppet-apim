class apim_store (
  $user                 = $apim_store::params::user,
  $user_group           = $apim_store::params::user_group,
  $user_group_id        = $apim_store::params::user_group_id,
  $service_name         = $apim_store::params::service_name,
  $start_script_template = $apim_store::params::start_script_template,
  $template_list        = $apim_store::params::template_list,
  $jre_version          = $apim_store::params::jre_version,

  # Master-datasource configs
  $wso2_carbon_db       = $apim_store::params::wso2_carbon_db,
  $wso2am_db            = $apim_store::params::wso2am_db,
  $wso2am_stat_db       = $apim_store::params::wso2am_stat_db,
  $wso2_mb_store_db     = $apim_store::params::wso2_mb_store_db,
)

  inherits apim_store::params {

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
    uid    => $apim_store::params::user_id,
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
    provider => $installer_provider,
    ensure   => installed,
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
