class wso2apim::startserver (
  $service_name = $wso2apim::params::service_name,
  $install_path = $wso2apim::params::install_path
)
inherits wso2apim::params {
  exec { 'systemctl daemon-reload':
    command => "systemctl daemon-reload",
    cwd     => "${install_path}/bin",
    path    => '/usr/bin:/usr/sbin:/bin',
  }

  service { $service_name:
    enable => true,
    ensure => running,
  }
}
