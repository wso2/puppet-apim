class apim_km::params {
  $user = 'wso2carbon'
  $user_id = 803
  $user_group = 'wso2'
  $user_home = '/home/$user'
  $user_group_id = 803
  $service_name = 'wso2am'
  $hostname = 'localhost'
  $mgt_hostname = 'localhost'
  $jre_version = 'jre1.8.0_172'

  # Define the template template
  $start_script_template = 'bin/wso2server.sh'
  $template_list = [
    'repository/conf/datasources/master-datasources.xml',
    # 'bin/wso2server.sh',
    # 'repository/conf/api-manager.xml',
    # 'repository/conf/carbon.xml',
    # 'repository/conf/registry.xml',
    # 'repository/conf/user-mgt.xml',
    # 'repository/conf/axis2/axis2.xml',
    # 'repository/conf/identity/identity.xml',
    # 'repository/conf/security/authenticators.xml',
    # 'repository/conf/tomcat/catalina-server.xml',
  ]

  # Master-datasources config params
  $wso2_carbon_db = {
    url               => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE',
    username          => 'wso2carbon',
    password          => 'wso2carbon',
    driver_class_name => 'org.h2.Driver',
  }

  $wso2am_db = {
    url               => 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE',
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
}
