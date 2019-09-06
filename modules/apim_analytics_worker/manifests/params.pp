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

# Claas apim_analytics_worker::params
# This class includes all the necessary parameters.
class apim_analytics_worker::params inherits apim_common::params {

  # Define the template
  $start_script_template = "bin/worker.sh"

  # Define the template
  $template_list = [
    'conf/worker/deployment.yaml'
  ]

  # Define file list
  $file_list = []

  # Define remove file list
  $file_removelist = []

  # -------------- Deployment.yaml Config -------------- #

  # Carbon Configuration Parameters
  $carbon_id = 'wso2-am-analytics'
  $ports_offset = 1

  # Configuration used for the databridge communication
  $binary_data_receiver_tcp_pool_side = 100
  $binary_data_receiver_ssl_pool_side = 100

  $state_persistence_enabled = 'false'
  $state_persistence_interval = 1
  $state_persistence_revisions = 2

  # transport.http config
  $default_listener_host = '0.0.0.0'
  $msf4j_host = '0.0.0.0'
  $msf4j_listener_keystore = '${carbon.home}/resources/security/wso2carbon.jks'
  $msf4j_listener_keystore_password = 'wso2carbon'
  $msf4j_listener_keystore_cert_pass = 'wso2carbon'

  # siddhi.stores.query.api config
  $siddhi_default_listener_host = '0.0.0.0'
  $siddhi_msf4j_host = '0.0.0.0'
  $siddhi_msf4j_listener_keystore = '${carbon.home}/resources/security/wso2carbon.jks'
  $siddhi_msf4j_listener_keystore_password = 'wso2carbon'
  $siddhi_msf4j_listener_keystore_cert_pass = 'wso2carbon'

  # Data Sources Configurations
  $message_tracing_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/MESSAGE_TRACING_DB;AUTO_SERVER=TRUE'
  $message_tracing_db_username = 'wso2carbon'
  $message_tracing_db_password = 'wso2carbon'
  $message_tracing_db_driver = 'org.h2.Driver'
  $message_tracing_db_test_query = 'SELECT 1'

  $persistence_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/worker/database/WSO2AM_MGW_ANALYTICS_DB;AUTO_SERVER=TRUE'
  $persistence_db_username = 'wso2carbon'
  $persistence_db_password = 'wso2carbon'
  $persistence_db_driver = 'com.mysql.jdbc.Driver'
  $persistence_db_test_query = 'SELECT 1'

  $cluster_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/worker/database/WSO2AM_MGW_ANALYTICS_DB;AUTO_SERVER=TRUE'
  $cluster_db_username = 'wso2carbon'
  $cluster_db_password = 'wso2carbon'
  $cluster_db_driver = 'com.mysql.jdbc.Driver'
  $cluster_db_test_query = 'SELECT 1'

  # Cluster configurations
  $cluster_config_enabled = 'false'
  $cluster_config_group_id = 'sp'
  $cluster_config_heartbeat_interval = 3000
  $cluster_config_max_retry = 3
  $cluster_config_polling_interval = 3000

  # Configurations for High Availability deployments
  # $deployment_type = 'ha'
  # $eventSyncServer_host = 'localhost'
  # $eventSyncServer_port = '9893'
  # $eventSyncServer_advertised_host = 'localhost'
  # $eventSyncServer_advertised_port = '9893'

  # Configurations for distributed deployments
  # $deployment_type = 'distributed'
  # $https_interface_host = '192.168.1.3'
  # $https_interface_port = '9443'
  # $https_interface_username = 'admin'
  # $https_interface_password = 'admin'
  # $resource_managers = [
  #   {
  #     host     => '192.168.1.3',
  #     port     => '9443',
  #     username => 'admin',
  #     password => 'admin'
  #   },
  #   {
  #     host     => '192.168.1.1',
  #     port     => '9443',
  #     username => 'admin',
  #     password => 'admin'
  #   }
  # ]
}
