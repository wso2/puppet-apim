class apim_tm::startserver (
  $service_name = $apim_tm::params::service_name
)
  inherits apim_tm::params {

  service { $service_name:
    enable => true,
    ensure => running,
  }
}
