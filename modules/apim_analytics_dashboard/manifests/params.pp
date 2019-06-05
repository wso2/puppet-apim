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

# Class apim_analytics_dashboard::params
# This class includes all the necessary parameters.
class apim_analytics_dashboard::params {
  $user = 'wso2carbon'
  $user_group = 'wso2'
  $product = 'wso2am-analytics'
  $product_version = '2.6.0'
  $profile = 'dashboard'
  $service_name = "${product}-${profile}"

  # JDK Distributions
  if $::osfamily == 'redhat' {
    $lib_dir = "/usr/lib64/wso2"
  }
  elsif $::osfamily == 'debian' {
    $lib_dir = "/usr/lib/wso2"
  }
  $jdk_name = 'amazon-corretto-8.202.08.2-linux-x64'
  $java_home = "${lib_dir}/${jdk_name}"

  # Define the template
  $start_script_template = "bin/${profile}.sh"

  # Define the template
  $template_list = [
    'conf/dashboard/deployment.yaml'
  ]

  # -------------- Deployment.yaml Config -------------- #

  # Carbon Configuration Parameters
  $ports_offset = 3

  # Data Sources Configuration
  $business_rules_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/BUSINESS_RULES_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $business_rules_db_username = 'wso2carbon'
  $business_rules_db_password = 'wso2carbon'
  $business_rules_db_driver = 'org.h2.Driver'

  $status_dashboard_db_url = 'jdbc:h2:${sys:carbon.home}/wso2/${sys:wso2.runtime}/database/wso2_status_dashboard;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;MVCC=TRUE'
  $status_dashboard_db_username = 'wso2carbon'
  $status_dashboard_db_password = 'wso2carbon'
  $status_dashboard_db_driver = 'org.h2.Driver'

  # wso2.business.rules.manager config
  $business_rules_manager_username = 'admin'
  $business_rules_manager_password = 'admin'

  # wso2.status.dashboard config
  $status_dashboard_username = 'admin'
  $status_dashboard_password = 'admin'

  # transport.http configuration
  $default_host = '0.0.0.0'
  $default_listener_keystore = '${carbon.home}/resources/security/wso2carbon.jks'
  $default_listener_keystore_password = 'wso2carbon'
  $default_listener_keystore_cert_pass = 'wso2carbon'

  # Directories
  $products_dir = "/usr/local/wso2"

  # Product and installation information
  $product_binary = "${product}-${product_version}.zip"
  $distribution_path = "${products_dir}/${product}/${profile}/${product_version}"
  $install_path = "${distribution_path}/${product}-${product_version}"
}
