#!/bin/bash

rm -rf /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone_xml_history/current

sed -i 's/jdbc:sqlserver:\/\/LIONFISH;databaseName=lpd_production;integratedSecurity=true/$connection-url/g' /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml
sed -i 's/dbuser/$username/g' /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml
sed -i 's/dbpass/$password/g' /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml

echo SCK_PRIVATE_EXPORT_TEMPLATE=$SCK_PRIVATE_EXPORT_TEMPLATE > /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_PUBLIC_EXPORT_TEMPLATE=$SCK_PUBLIC_EXPORT_TEMPLATE >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_EXPORT_FOLDER=$SCK_EXPORT_FOLDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_REPORT_PROVIDER=$SCK_REPORT_PROVIDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_REPORT_SUPPORT_MAIL=$SCK_REPORT_SUPPORT_MAIL >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_SUPER_ADMIN=$SCK_SUPER_ADMIN >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_BING_KEY=$SCK_BING_KEY >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_SHAPEFILE_IMPORT_SERVICE_URL=$SCK_SHAPEFILE_IMPORT_SERVICE_URL >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_SHAPEFILE_FOLDER=$SCK_SHAPEFILE_FOLDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_SHAPEFILE_TPL_FOLDER=$SCK_SHAPEFILE_TPL_FOLDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_DOCUMENTATIONFILE_FOLDER=$SCK_DOCUMENTATIONFILE_FOLDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_USER_GUIDE_FOLDER=$SCK_USER_GUIDE_FOLDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_ARCHIVE_PROVIDER=$SCK_ARCHIVE_PROVIDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_DOCUMENTATION_PROVIDER=$SCK_DOCUMENTATION_PROVIDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_TEMPLATE_PROVIDER=$SCK_TEMPLATE_PROVIDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_USER_GUIDE_PROVIDER=$SCK_USER_GUIDE_PROVIDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_BENEFICIARY_FEATURE_LAYER_URL=$SCK_BENEFICIARY_FEATURE_LAYER_URL >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_BENEFICIARY_PUBLIC_LAYER=$SCK_BENEFICIARY_PUBLIC_LAYER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_ARCGIS_PROXY=$SCK_ARCGIS_PROXY >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_SPATIAL_REFERENCE=$SCK_SPATIAL_REFERENCE >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_BACKGROUND_LAYER=$SCK_BACKGROUND_LAYER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo mail.smtp.host=$mail.smtp.host >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo mail.smtp.user=$mail.smtp.user >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_MAIL_SMTP_PASSWORD=$SCK_MAIL_SMTP_PASSWORD >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_MAIL_STMP_FROM_FOR_BENEF=$SCK_MAIL_STMP_FROM_FOR_BENEF >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_MAIL_OUTCOPY=$SCK_MAIL_OUTCOPY >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_MAIL_QC=$SCK_MAIL_QC >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_TABLE_PREFIX=$SCK_TABLE_PREFIX >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_LPD_WEB_APPLICATION=$SCK_LPD_WEB_APPLICATION >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_AUTH=$SCK_AUTH >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_LDAP_URL=$SCK_LDAP_URL >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_LDAP_UID=$SCK_LDAP_UID >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_LDAP_BASE_CONTEXT=$SCK_LDAP_BASE_CONTEXT >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_BENEFICIARY_ACCESS_ACTIVATION_TOKEN_VALIDITY=$SCK_BENEFICIARY_ACCESS_ACTIVATION_TOKEN_VALIDITY >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo SCK_BENEFICIARY_ACCESS_VALIDITY=$SCK_BENEFICIARY_ACCESS_VALIDITY >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo LPD_PRINT_SERVICE=$LPD_PRINT_SERVICE >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo LPD_EXTRACT_SPATIAL_DATA_SERVICE=$LPD_EXTRACT_SPATIAL_DATA_SERVICE >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
echo LPD_SEARCH_LAYER=$LPD_SEARCH_LAYER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties

