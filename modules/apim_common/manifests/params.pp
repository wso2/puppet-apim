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

class common::params {

  # ----- Master-datasources config params -----

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

  # user-mgt.xml
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
