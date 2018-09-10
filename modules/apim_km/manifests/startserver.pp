class apim_km::startserver (
  $service_name = $apim_km::params::service_name
)
  inherits apim_km::params {

  service { $service_name:
    enable => true,
    ensure => running,
  }
}
