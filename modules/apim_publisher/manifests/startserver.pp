class apim_publisher::startserver (
  $service_name = $apim_publisher::params::service_name
)
  inherits apim_publisher::params {

  service { $service_name:
    enable => true,
    ensure => running,
  }
}
