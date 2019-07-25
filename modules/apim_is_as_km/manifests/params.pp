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

# Class apim_is_as_km::params
# This class includes all the necessary parameters.
class apim_is_as_km::params inherits apim_common::params {

  $start_script_template = 'bin/wso2server.sh'
  $jvmxms = '256m'
  $jvmxmx = '1024m'

  $template_list = [
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/datasources/bps-datasources.xml',
    'repository/conf/carbon.xml',
    'repository/conf/user-mgt.xml',
    'repository/conf/axis2/axis2.xml',
    'repository/conf/api-manager.xml',
    'repository/conf/registry.xml',
    'repository/conf/tomcat/catalina-server.xml',
    'repository/conf/identity/embedded-ldap.xml',
    'repository/conf/identity/identity.xml',
  ]

  # Define file list
  $file_list = []

  # Define remove file list
  $file_removelist = []

  # ----- Carbon.xml config params -----
  $ports_offset = 0
  /*
     Host name or IP address of the machine hosting this server
     e.g. www.wso2.org, 192.168.1.10
     This is will become part of the End Point Reference of the
     services deployed on this server instance.
  */
  $hostname = 'localhost'

  # Clustering configuraitons
  $clustering_enabled = 'false'
  $clustering_domain = 'wso2.carbon.domain'
  $membership_scheme = 'multicast'
  $local_member_host = $::ipaddress
  $clustering_members = [
    {
      host_name => '127.0.0.1',
      port => '4000'
    }
  ]

  # Datasource configurations
  $wso2identity_db_url = 'jdbc:h2:repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE'
  $wso2identity_db_username = 'wso2carbon'
  $wso2identity_db_password = 'wso2carbon'
  $wso2identity_db_driver = 'org.h2.Driver'
  $wso2identity_db_validation_query = 'SELECT 1'

  $wso2bps_db_url = 'jdbc:h2:file:repository/database/jpadb;DB_CLOSE_ON_EXIT=FALSE;MVCC=TRUE'
  $wso2bps_db_username = 'wso2carbon'
  $wso2bps_db_password = 'wso2carbon'
  $wso2bps_db_driver = 'org.h2.Driver'
  $wso2bps_db_validation_query = 'SELECT 1'

  # LDAP Configurations
  $embedded_ldap_enabled = 'false'
}
