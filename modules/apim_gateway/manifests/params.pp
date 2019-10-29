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

# Class apim_gateway::params
# This class includes all the necessary parameters.
class apim_gateway::params inherits apim_common::params {

  $start_script_template = 'bin/wso2server.sh'
  $jvmxms = '256m'
  $jvmxmx = '1024m'

  $template_list = [
    'repository/conf/deployment.toml',
  ]

  # Define file list
  $file_list = []

  # Define remove file list
  $file_removelist = []

  # ----- Carbon.xml config params -----
  /*
     Host name or IP address of the machine hosting this server
     e.g. www.wso2.org, 192.168.1.10
     This is will become part of the End Point Reference of the
     services deployed on this server instance.
  */
  $hostname = 'localhost'

  # ----- api-manager.xml config params -----
  $jms_conn_factory = 'amqp://${admin.username}:${admin.password}@clientid/carbon?brokerlist=\'tcp://${carbon.local.ip}:${jms.port}\''
}
