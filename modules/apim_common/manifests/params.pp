#----------------------------------------------------------------------------
#  Copyright (c) 2021 WSO2, Inc. http://www.wso2.org
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
#----------------------------------------------------------------------------

class apim_common::params {

  $packages = ["unzip"]
  $version = "4.1.0"

  # Set the location the product packages should reside in (eg: "local" in the /files directory, "remote" in a remote location)
  $pack_location = "local"
  # $pack_location = "remote"
  # $remote_jdk = "<URL_TO_JDK_FILE>"

  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802

  # Performance tuning configurations
  $enable_performance_tuning = false
  $performance_tuning_flie_list = [
    'etc/sysctl.conf',
    'etc/security/limits.conf',
  ]

  # JDK Distributions
  $java_dir = "/opt"
  $java_symlink = "${java_dir}/java"
  $jdk_name = 'amazon-corretto-8.302.08.1-linux-x64'
  $java_home = "${java_dir}/${jdk_name}"

  $profile = $profile
  $target = "/mnt"
  $product_dir = "${target}/${profile}"
  $pack_dir = "${target}/${profile}/packs"
  $wso2_service_name = "wso2${profile}"

  # ----- Profile configs -----
  case $profile {
    'apim_gateway': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_GATEWAY_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/api-manager.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=gateway-worker"
    }
    'apim_control_plane': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_CONTROL_PLANE_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/api-manager.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=control-plane"
    }
    'apim_tm': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_TRAFFICMANAGER_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/api-manager.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=traffic-manager"
    }
    default: {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/api-manager.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = ""
    }
  }

  # Pack Directories
  $carbon_home = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"

  # Server stop retry configs
  $try_count = 5
  $try_sleep = 5

  # ----- api-manager.xml config params -----
  $analytics_enabled = 'false'
  $analytics_config_endpoint = 'https://localhost:8080/auth/v1'
  $analytics_auth_token = ''

  $throttle_decision_endpoints = '"tcp://tm1.local:5672","tcp://tm2.local:5672"'
  $throttling_url_group = [
    {
      traffic_manager_urls      => '"tcp://tm1.local:9611"',
      traffic_manager_auth_urls => '"ssl://tm1.local:9711"'
    },
    {
      traffic_manager_urls      => '"tcp://tm2.local:9611"',
      traffic_manager_auth_urls => '"ssl://tm2.local:9711"'
    }
  ]

  $gateway_environments = [
    {
      type                                  => 'hybrid',
      name                                  => 'Default',
      description                           => 'This is a hybrid gateway that handles both production and sandbox token traffic.',
      server_url                            => 'https://localhost:${mgt.transport.https.port}${carbon.context}services/',
      ws_endpoint                           => 'ws://localhost:9099',
      wss_endpoint                          => 'wss://localhost:8099',
      http_endpoint                         => 'http://localhost:8280',
      https_endpoint                        => 'https://localhost:8243',
      websub_event_receiver_http_endpoint   => 'http://localhost:9021',
      websub_event_receiver_https_endpoint  => 'https://localhost:8021'
    }
  ]

  $gateway_labels = ["Default"]

  $key_manager_server_url = 'https://localhost:${mgt.transport.https.port}${carbon.context}services/'
  $key_validator_thrift_server_host = 'localhost'

  $api_devportal_url = 'https://localhost:${mgt.transport.https.port}/devportal'
  $throttle_service_url = 'https://localhost:${mgt.transport.https.port}${carbon.context}services/'

  $traffic_manager_receiver_url = 'tcp://${carbon.local.ip}:${receiver.url.port}'
  $traffic_manager_auth_url = 'ssl://${carbon.local.ip}:${auth.url.port}'

  # ----- Master-datasources config params -----

  $wso2am_db_url = 'jdbc:h2:./repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE'
  $wso2am_db_username = 'wso2carbon'
  $wso2am_db_password = 'wso2carbon'
  $wso2am_db_type = 'h2'
  $wso2am_db_validation_query = 'SELECT 1'

  $wso2shared_db_url = 'jdbc:h2:./repository/database/WSO2SHARED_DB;DB_CLOSE_ON_EXIT=FALSE'
  $wso2shared_db_username = 'wso2carbon'
  $wso2shared_db_password = 'wso2carbon'
  $wso2shared_db_type = 'h2'
  $wso2shared_db_validation_query = 'SELECT 1'

  # ----- Carbon.xml config params -----
  $ports_offset = 0

  $key_store_location = 'wso2carbon.jks'
  $analytics_key_store_location = '${sys:carbon.home}/resources/security/wso2carbon.jks'
  $key_store_password = 'wso2carbon'
  $key_store_key_alias = 'wso2carbon'
  $key_store_key_password = 'wso2carbon'

  $internal_keystore_location = 'wso2carbon.jks'
  $internal_keystore_password = 'wso2carbon'
  $internal_keystore_key_alias = 'wso2carbon'
  $internal_keystore_key_password = 'wso2carbon'

  $trust_store_location = 'client-truststore.jks'
  $analytics_trust_store_location = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $trust_store_password = 'wso2carbon'

  # ----- user-mgt.xml config params -----
  $admin_username = 'admin'
  $admin_password = 'admin'

  $event_listener_notification_endpoint = 'https://localhost:${mgt.transport.https.port}/internal/data/v1/notify'
}
