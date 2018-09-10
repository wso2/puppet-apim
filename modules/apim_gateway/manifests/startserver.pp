class apim_gateway::startserver (
  $service_name = $apim_gateway::params::service_name
)
  inherits apim_gateway::params {

  service { $service_name:
    enable => true,
    ensure => running,
  }
}
