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

# Class apim_publisher::params
# This class includes all the necessary parameters.
class apim_publisher::params inherits apim_common::params {

  $start_script_template = 'bin/wso2server.sh'
  $jvmxms = '256m'
  $jvmxmx = '1024m'

  $template_list = [
    'repository/conf/api-manager.xml',
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/carbon.xml',
    'repository/conf/user-mgt.xml',
    'repository/conf/axis2/axis2.xml',
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
  $mgt_hostname = 'localhost'

  # ----- axis2.xml config params -----
  $clustering_enabled = 'false'
  $clustering_membership_scheme = 'multicast'
}
