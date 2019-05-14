# ----------------------------------------------------------------------------
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
# ----------------------------------------------------------------------------

# Class apim_analytics_worker_master::params
# This class includes all the necessary parameters.
class apim_analytics_worker_master::params {
  $user = 'wso2carbon'
  $user_group = 'wso2'
  $product = 'wso2am-analytics'
  $product_version = '2.6.0'
  $profile = 'worker'

  # Define the template
  $template_list = [
    'conf/dashboard/deployment.yaml'
  ]

  # -------------- Deployment.yaml Config -------------- #

  # Carbon Configuration Parameters
  $ports_offset = 1

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

  # Data Sources Configuration
  $message_tracing_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/dashboard/database/MESSAGE_TRACING_DB;AUTO_SERVER=TRUE'
  $message_tracing_db_username = 'wso2carbon'
  $message_tracing_db_password = 'wso2carbon'
  $message_tracing_db_driver = 'org.h2.Driver'

  # Directories
  $products_dir = "/usr/local/wso2"

  # Product and installation paths
  $product_binary = "${product}-${product_version}.zip"
  $distribution_path = "${products_dir}/${product}/${profile}/${product_version}"
  $install_path = "${distribution_path}/${product}-${product_version}"
}
