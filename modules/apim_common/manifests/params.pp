#----------------------------------------------------------------------------
#  Copyright (c) 2019 WSO2, Inc. http://www.wso2.org
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
  $version = "3.1.0"

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
  $jdk_name = 'amazon-corretto-8.222.10.1-linux-x64'
  $java_home = "${java_dir}/${jdk_name}"

  $profile = $profile
  $target = "/mnt"
  $product_dir = "${target}/${profile}"
  $pack_dir = "${target}/${profile}/packs"
  $wso2_service_name = "wso2${profile}"

  # ----- Profile configs -----
  case $profile {
    'apim_analytics_dashboard': {
      $pack = "wso2am-analytics-${version}"
      # $remote_pack = "<URL_TO_APIM_ANALYTICS_WORKER_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/dashboard.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2/dashboard/runtime.pid"
    }
    'apim_analytics_worker': {
      $pack = "wso2am-analytics-${version}"
      # $remote_pack = "<URL_TO_APIM_ANALYTICS_WORKER_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/worker.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2/worker/runtime.pid"
    }
    'apim_gateway': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_GATEWAY_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=gateway-worker"
    }
    'apim_is_as_km': {
      $pack = "wso2is-km-5.10.0"
      # $remote_pack = "<URL_TO_IS_AS_KM_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
    }
    'apim_km': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_KEYMANAGER_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=api-key-manager"
    }
    'apim_publisher': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_PUBLISHER_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=api-publisher"
    }
    'apim_devportal': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_DEVPORTAL_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=api-devportal"
    }
    'apim_tm': {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_TRAFFICMANAGER_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "-Dprofile=traffic-manager"
    }
    default: {
      $pack = "wso2am-${version}"
      # $remote_pack = "<URL_TO_APIM_PACK>"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
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
  $stream_processor_username = '${admin.username}'
  $stream_processor_password = '${admin.password}'
  $stream_processor_rest_api_url = 'https://localhost:7444'
  $stream_processor_restapi_url = 'https://localhost:7444'
  $stream_processor_rest_api_username = '${admin.username}'
  $stream_processor_rest_api_password = '${admin.password}'
  $analytics_url_group = [
    {
      analytics_urls      => '"tcp://analytics1.local:7612"',
      analytics_auth_urls => '"ssl://analytics1.local:7712"'
    },
    {
      analytics_urls      => '"tcp://analytics2.local:7612"',
      analytics_auth_urls => '"ssl://analytics2.local:7712"'
    }
  ]

  $throttle_decision_endpoints = '"tcp://tm1.local:5672","tcp://tm2.local:5672"'
  $throttling_url_group = [
    {
      traffic_manager_urls      => '"tcp://tm1.local:9611"',
      traffic_manager_auth_urls => '"ssl://tm1.local:9771"'
    },
    {
      traffic_manager_urls      => '"tcp://tm2.local:9611"',
      traffic_manager_auth_urls => '"ssl://tm2.local:9771"'
    }
  ]

  $gateway_environments = [
    {
      type                => 'hybrid',
      name                => 'Production and Sandbox',
      description         => 'This is a hybrid gateway that handles both production and sandbox token traffic.',
      server_url          => 'https://localhost:${mgt.transport.https.port}${carbon.context}services/',
      ws_endpoint         => 'ws://localhost:9099',
      wss_endpoint        => 'wss://localhost:8099',
      http_endpoint       => 'http://localhost:${http.nio.port}',
      https_endpoint      => 'https://localhost:${https.nio.port}'
    }
  ]

  $key_manager_server_url = 'https://localhost:${mgt.transport.https.port}${carbon.context}services/'
  $key_validator_thrift_server_host = 'localhost'

  $api_devportal_url = 'https://localhost:${mgt.transport.https.port}/devportal'
  $api_devportal_server_url = 'https://localhost:${mgt.transport.https.port}${carbon.context}services/'

  $traffic_manager_receiver_urls = '["tcp://localhost:9611","tcp://localhost:9611"]'
  $traffic_manager_auth_urls = '["ssl://localhost:9711","ssl://localhost:9711"]'

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

  # ----- Analytics config params -----

  # Configuration used for the databridge communication
  $databridge_config_worker_threads = 10
  $databridge_config_keystore_location = '${sys:carbon.home}/resources/security/wso2carbon.jks'
  $databridge_config_keystore_password = 'wso2carbon'
  $binary_data_receiver_hostname = '127.0.0.1'
  $tcp_receiver_thread_pool_size = 100
  $ssl_receiver_thread_pool_size = 100

  # Configuration of the Data Agents - to publish events through
  $thrift_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $thrift_agent_trust_store_password = 'wso2carbon'
  $binary_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $binary_agent_trust_store_password = 'wso2carbon'

  # Secure Vault Configuration
  $securevault_keystore_location = '${sys:carbon.home}/resources/security/securevault.jks'
  $securevault_privatekey_alias = 'wso2carbon'
  $securevault_secret_properties_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/secrets.properties'
  $securevault_masterkeyreader_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/master-keys.yaml'

  # Data Sources Configurations
  $wso2_metrics_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/metrics;AUTO_SERVER=TRUE'
  $wso2_metrics_db_username = 'wso2carbon'
  $wso2_metrics_db_password = 'wso2carbon'
  $wso2_metrics_db_driver = 'org.h2.Driver'
  $wso2_metrics_db_test_query = 'SELECT 1'

  $wso2_permissions_db_url =
    'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/PERMISSION_DB;IFEXISTS=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $wso2_permissions_db_username = 'wso2carbon'
  $wso2_permissions_db_password = 'wso2carbon'
  $wso2_permissions_db_driver = 'org.h2.Driver'
  $wso2_permissions_db_test_query = 'SELECT 1'

  $apim_analytics_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/worker/database/WSO2AM_STATS_DB;AUTO_SERVER=TRUE'
  $apim_analytics_db_username = 'wso2carbon'
  $apim_analytics_db_password = 'wso2carbon'
  $apim_analytics_db_driver = 'org.h2.Driver'
  $apim_analytics_db_test_query = 'SELECT 1'

  $am_db_url = 'jdbc:h2:${sys:carbon.home}/../wso2am-3.1.0/repository/database/WSO2AM_DB;AUTO_SERVER=TRUE'
  $am_db_username = 'wso2carbon'
  $am_db_password = 'wso2carbon'
  $am_db_driver = 'org.h2.Driver'
  $am_test_query = 'SELECT 1'
}
