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
  $version = "2.6.0"

  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802
  $local_ip = $::ipaddress

  # JDK Distributions
  $java_dir = "/opt"
  $java_symlink = "${java_dir}/java"
  $jdk_name = 'amazon-corretto-8.202.08.2-linux-x64'
  $java_home = "${java_dir}/${jdk_name}"

  $profile = $profile
  $target = "/mnt"
  $product_dir = "${target}/${profile}"
  $pack_dir = "${target}/${profile}/packs"

  # ----- Profile configs -----
  case $profile {
    'apim_analytics_dashboard': {
      $pack = "wso2am-analytics-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/dashboard.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2/dashboard/runtime.pid"
    }
    'apim_analytics_worker': {
      $pack = "wso2am-analytics-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/worker.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2/worker/runtime.pid"
    }
    'apim_gateway': {
      $pack = "wso2am-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "--optimize -Dprofile=gateway-worker -DworkerNode=true"
    }
    'apim_km': {
      $pack = "wso2am-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "--optimize -Dprofile=api-key-manager"
    }
    'apim_publisher': {
      $pack = "wso2am-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "--optimize -Dprofile=api-publisher"
    }
    'apim_store': {
      $pack = "wso2am-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "--optimize -Dprofile=api-store"
    }
    'apim_tm': {
      $pack = "wso2am-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"
      $optimize_params = "--optimize -Dprofile=traffic-manager"
    }
    default: {
      $pack = "wso2am-${version}"
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

  # ----- Master-datasources config params -----

  $wso2carbon_db_url = 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE'
  $wso2carbon_db_username = 'wso2carbon'
  $wso2carbon_db_password = 'wso2carbon'
  $wso2carbon_db_driver = 'org.h2.Driver'

  $wso2am_db_url = 'jdbc:h2:repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE'
  $wso2am_db_username = 'wso2carbon'
  $wso2am_db_password = 'wso2carbon'
  $wso2am_db_driver = 'org.h2.Driver'

  $stat_db_url = 'jdbc:h2:../tmpStatDB/WSO2AM_STATS_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;AUTO_SERVER=TRUE'
  $stat_db_username = 'wso2carbon'
  $stat_db_password = 'wso2carbon'
  $stat_db_driver = 'org.h2.Driver'

  $mb_store_db_url = 'jdbc:h2:repository/database/WSO2MB_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
  $mb_store_db_username = 'wso2carbon'
  $mb_store_db_password = 'wso2carbon'
  $mb_store_driver = 'org.h2.Driver'

  # ----- Carbon.xml config params -----
  $ports_offset = 0

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

  # ----- user-mgt.xml config params -----
  $admin_username = 'admin'
  $admin_password = 'admin'

  # -------------- Deployment.yaml Config -------------- #

  # Configuration used for the databridge communication
  $databridge_keystore = '${sys:carbon.home}/resources/security/wso2carbon.jks'
  $databridge_keystore_password = 'wso2carbon'
  $binary_data_receiver_hostname = '0.0.0.0'

  # Configuration of the Data Agents - to publish events through
  $thrift_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $thrift_agent_trust_store_password = 'wso2carbon'
  $binary_agent_trust_store = '${sys:carbon.home}/resources/security/client-truststore.jks'
  $binary_agent_trust_store_password = 'wso2carbon'

  # Secure Vault Configuration
  $securevault_key_store = '${sys:carbon.home}/resources/security/securevault.jks'
  $securevault_private_key_alias = 'wso2carbon'
  $securevault_secret_properties_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/secrets.properties'
  $securevault_master_key_reader_file = '${sys:carbon.home}/conf/${sys:wso2.runtime}/master-keys.yaml'

  # Data Sources Configuration
  $metrics_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/metrics;AUTO_SERVER=TRUE'
  $metrics_db_username = 'wso2carbon'
  $metrics_db_password = 'wso2carbon'
  $metrics_db_driver = 'org.h2.Driver'

  $permission_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/PERMISSION_DB;IFEXISTS=TRUE;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $permission_db_username = 'wso2carbon'
  $permission_db_password = 'wso2carbon'
  $permission_db_driver = 'org.h2.Driver'

  $apim_analytics_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/worker/database/WSO2AM_STATS_DB;AUTO_SERVER=TRUE'
  $apim_analytics_db_username = 'wso2carbon'
  $apim_analytics_db_password = 'wso2carbon'
  $apim_analytics_db_driver = 'org.h2.Driver'
}
