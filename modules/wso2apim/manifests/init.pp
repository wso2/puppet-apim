class wso2apim (
  $wso2_user    = 'ubuntu',
  $wso2_group   = 'ubuntu',
  $service_name = $wso2apim::params::service_name,
  $install_path = $wso2apim::params::install_path,
)

inherits wso2apim::params {

  if $::osfamily == 'redhat' {
    $wso2apim_package = 'wso2am-linux-installer-x64-2.5.0.rpm'
    $installer_provider = 'rpm'
  }
  elsif $::osfamily == 'debian' {
    $wso2apim_package = 'wso2am-linux-installer-x64-2.5.0.deb'
    $installer_provider = 'dpkg'
  }

  # Ensure the installation directory is available
  file { '/opt/$service_name':
    ensure => 'directory',
    owner  => $wso2_user,
    group  => $wso2_group,
  }

  # Copt the installer to the directory
  file { '/opt/$service_name/$wso2apim_package':
    mode   => "0644",
    owner  => $wso2_user,
    group  => $wso2_group,
    source => "puppet:///modules/wso2apim/$wso2apim_package",
  }

  # Install WSO2 API Manager
  package { 'wso2apim':
    provider => "$installer_provider",
    ensure   => installed,
    source   => '/opt/$service_name/$wso2apim_package'
  }

  # Template list
  $templates = [
    'bin/wso2server.sh',
    'repository/conf/api-manager.xml',
    'repository/conf/carbon.xml',
    'repository/conf/registry.xml',
    'repository/conf/user-mgt.xml',
    'repository/conf/axis2/axis2.xml',
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/identity/identity.xml',
    'repository/conf/security/authenticators.xml',
    'repository/conf/tomcat/catalina-server.xml',
  ]

  $templates.each | String $template | {
    file { "${install_path}/${template}":
      ensure => file,
      owner => $wso2_user,
      group => $wso2_group,
      mode => '0754',
      content => template("wso2apim/${template}.erb")
    }
  }

  # Copy service file to init.d
  file { "/etc/init.d/${service_name}":
    ensure => present,
    owner => root,
    group => root,
    mode => '0755',
    content => template("wso2apim/${service_name}.erb"),
  }

  # Copy the unit file required to deploy the server as a service
  file { "/etc/systemd/system/${service_name}.service":
    ensure => present,
    owner => root,
    group => root,
    mode => '0755',
    content => template("wso2apim/${service_name}.service.erb"),
  }

}
