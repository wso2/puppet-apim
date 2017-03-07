#----------------------------------------------------------------------------
#  Copyright (c) 2016 WSO2, Inc. http://www.wso2.org
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

class wso2is_prepacked::configure {

  $carbon_home              = $wso2is_prepacked::carbon_home
  $wso2_user                = $wso2is_prepacked::wso2_user
  $wso2_group               = $wso2is_prepacked::wso2_group
  $sso_service_providers    = $wso2is_prepacked::sso_service_providers

  contain wso2base::configure

  if ($sso_service_providers != undef and size($sso_service_providers) > 0) {

    $server_list = keys($sso_service_providers)

    wso2base::configure_idp_service_providers {
      $server_list:
        owner       => $wso2_user,
        group       => $wso2_group,
        carbon_home => $carbon_home,
        wso2_module => $caller_module_name,
        require     => Class[Wso2base::Configure]
    }

  }

}
