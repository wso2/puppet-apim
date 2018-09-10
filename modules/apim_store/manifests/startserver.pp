class apim_store::startserver (
  $service_name = $apim_store::params::service_name
)
  inherits apim_store::params {

  service { $service_name:
    enable => true,
    ensure => running,
  }
}
