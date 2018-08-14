class apim::startserver (
  $service_name = $apim::params::service_name
)
  inherits apim::params {

  service { $service_name:
    enable => true,
    ensure => running,
  }
}
