# ----------------------------------------------------------------------------
#  Copyright (c) 2018 WSO2, Inc. http://www.wso2.org
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

# Class apim_gateway::params
# This class includes all the necessary parameters.
class apim_gateway::params {
  $user = 'wso2carbon'
  $user_group = 'wso2'
  $product = 'wso2am'
  $product_version = '2.6.0'
  $service_name = 'wso2am'
  $profile = 'gateway'
  # $local_ip = $::ipaddress

  # JDK Distributions
  if $::osfamily == 'redhat' {
    $lib_dir = "/usr/lib64/wso2"
  }
  elsif $::osfamily == 'debian' {
    $lib_dir = "/usr/lib/wso2"
  }
  $jdk_name = 'amazon-corretto-8.202.08.2-linux-x64'
  $java_home = "${lib_dir}/${jdk_name}"

  $start_script_template = 'bin/wso2server.sh'
  $template_list = [
    'repository/conf/api-manager.xml',
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/carbon.xml',
    'repository/conf/user-mgt.xml',
    'repository/conf/axis2/axis2.xml',
  ]

  # ----- api-manager.xml config params -----
  $auth_manager_url = 'https://localhost:${mgt.transport.https.port}${carbon.context}services/'
  $auth_manager_username = '${admin.username}'
  $auth_manager_password = '${admin.password}'
  $auth_manager_check_permission_remotely = 'false'

  $api_gateway_url = 'https://localhost:${mgt.transport.https.port}${carbon.context}services/'
  $api_gateway_username = '${admin.username}'
  $api_gateway_password = '${admin.password}'
  $api_gateway_endpoint = 'http://${carbon.local.ip}:${http.nio.port},https://${carbon.local.ip}:${https.nio.port}'
  $api_gateway_ws_endpoint = 'ws://${carbon.local.ip}:9099'

  $analytics_enable = 'false'
  $stream_processor_url = '{tcp://localhost:7612}'
  $stream_processor_username = '${admin.username}'
  $stream_processor_password = '${admin.password}'
  $stream_processor_restapi_url = 'https://localhost:7444'
  $stream_processor_restapi_username = '${admin.username}'
  $stream_processor_restapi_password = '${admin.password}'

  $api_store_url = 'https://localhost:${mgt.transport.https.port}/store'
  $api_store_server_url = 'https://localhost:${mgt.transport.https.port}${carbon.context}services/'
  $api_store_username = '${admin.username}'
  $api_store_password = '${admin.password}'

  $api_publisher_url = 'https://localhost:${mgt.transport.https.port}/publisher'

  # ----- Carbon.xml config params -----
  $ports_offset = 0
  /*
     Host name or IP address of the machine hosting this server
     e.g. www.wso2.org, 192.168.1.10
     This is will become part of the End Point Reference of the
     services deployed on this server instance.
  */
  $hostname = 'localhost'
  $mgt_hostname = 'localhost'

  $key_store = '${carbon.home}/repository/resources/security/wso2carbon.jks'
  $key_store_type = 'JKS'
  $key_store_password = 'wso2carbon'
  $key_store_key_alias = 'wso2carbon'
  $key_store_key_password = 'wso2carbon'

  $internal_key_store = '${carbon.home}/repository/resources/security/wso2carbon.jks'
  $internal_key_store_type = 'JKS'
  $internal_key_store_password = 'wso2carbon'
  $internal_key_store_key_alias = 'wso2carbon'
  $internal_key_store_key_password = 'wso2carbon'

  $trust_store = '${carbon.home}/repository/resources/security/client-truststore.jks'
  $trust_store_type = 'JKS'
  $trust_store_password = 'wso2carbon'

  # ----- axis2.xml config params -----
  $clustering_enabled = 'false'
  $clustering_membership_scheme = 'multicast'

  # Directories
  $products_dir = "/usr/local/wso2"

  # Product and installation information
  $product_binary = "${product}-${product_version}.zip"
  $distribution_path = "${products_dir}/${product}/${profile}/${product_version}"
  $install_path = "${distribution_path}/${product}-${product_version}"

  # List of files that must contain agent specific configuraitons
  # if $deployment == "dev" {
  #   $config_file_list = [
  #     { "file" => "${install_path}/file1", "key" => "key1", "value" => "value1" },
  #   ]
  # }
  # elsif $deployment == "staging" {
  #   $config_file_list = [
  #     { "file" => "${install_path}/file1", "key" => "key1", "value" => "value1" },
  #   ]
  # }
  # elsif $deployment == "production" {
  #   $config_file_list = [
  #     { "file" => "${install_path}/repository/conf/axis2/axis2.xml", "key" => "LOCAL_IP", "value" => "${local_ip}" },
  #     { "file" => "${install_path}/repository/conf/carbon.xml", "key" => "HOSTNAME", "value" => "localhost" },
  #     { "file" => "${install_path}/repository/conf/carbon.xml", "key" => "MGT_HOSTNAME", "value" => "localhost" },
  #   ]
  # }
}
