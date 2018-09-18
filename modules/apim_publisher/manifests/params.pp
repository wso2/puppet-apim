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

# Claas apim::params
# This class includes all the necessary parameters.
class apim_publisher::params {
  $user = 'wso2carbon'
  $user_id = 802
  $user_group = 'wso2'
  $user_home = '/home/$user'
  $user_group_id = 802
  $service_name = 'wso2am'
  $hostname = 'localhost'
  $mgt_hostname = 'localhost'
  $jre_version = 'jre1.8.0_172'

  # Define the template template
  $start_script_template = 'bin/wso2server.sh'
  $template_list = [
    'repository/conf/api-manager.xml',
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/carbon.xml',
    # 'repository/conf/registry.xml',
    # 'repository/conf/user-mgt.xml',
    # 'repository/conf/axis2/axis2.xml',
    # 'repository/conf/identity/identity.xml',
    # 'repository/conf/security/authenticators.xml',
    # 'repository/conf/tomcat/catalina-server.xml',
  ]


  # ----- api-manager.xml config params -----
  $auth_manager = {
    server_url                => 'https://localhost:${mgt.transport.https.port}${carbon.context}services/',
    username                  => '${admin.username}',
    password                  => '${admin.password}',
    check_permission_remotely => 'false'
  }

  $api_gateway = {
    server_url          => 'https://localhost:${mgt.transport.https.port}${carbon.context}services/',
    username            => '${admin.username}',
    password            => '${admin.password}',
    gateway_endpoint    => 'http://${carbon.local.ip}:${http.nio.port},https://${carbon.local.ip}:${https.nio.port}',
    gateway_ws_endpoint => 'ws://${carbon.local.ip}:9099'
  }

  $analytics = {
    enable               => 'false',
    das_server_url       => '{tcp://localhost:7612}',
    das_username         => '${admin.username}',
    das_password         => '${admin.password}',
    das_restapi_url      => 'https://localhost:9444',
    das_restapi_username => '${admin.username}',
    das_restapi_password => '${admin.password}'
  }

  $api_store = {
    url        => 'https://localhost:${mgt.transport.https.port}/store',
    server_url => 'https://localhost:${mgt.transport.https.port}${carbon.context}services/',
    username   => '${admin.username}',
    password   => '${admin.password}'
  }

  $api_publisher = {
    url => 'https://localhost:${mgt.transport.https.port}/publisher'
  }

  # ----- Master-datasources config params -----
  $wso2_carbon_db = {
    url               => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE',
    username          => 'wso2carbon',
    password          => 'wso2carbon',
    driver_class_name => 'org.h2.Driver',
  }

  $wso2am_db = {
    url               => 'jdbc:h2:repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE',
    username          => 'wso2carbon',
    password          => 'wso2carbon',
    driver_class_name => 'org.h2.Driver',
  }

  $wso2am_stat_db = {
    url               =>
    'jdbc:h2:../tmpStatDB/WSO2AM_STATS_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000;AUTO_SERVER=TRUE',
    username          => 'wso2carbon',
    password          => 'wso2carbon',
    driver_class_name => 'org.h2.Driver',
  }

  $wso2_mb_store_db = {
    url               => 'jdbc:h2:repository/database/WSO2MB_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000',
    username          => 'wso2carbon',
    password          => 'wso2carbon',
    driver_class_name => 'org.h2.Driver',
  }

  # ----- Carbon.xml config params -----
  $ports = {
    offset => 0
  }

  $key_store = {
    location     => '${carbon.home}/repository/resources/security/wso2carbon.jks',
    type         => 'JKS',
    password     => 'wso2carbon',
    key_alias    => 'wso2carbon',
    key_password => 'wso2carbon',
  }

  $trust_store = {
    location => '${carbon.home}/repository/resources/security/client-truststore.jks',
    type     => 'JKS',
    password => 'wso2carbon'
  }
}
