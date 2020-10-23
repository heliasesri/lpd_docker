FROM openjdk:7
MAINTAINER Helias B

ARG SCK_PRIVATE_EXPORT_TEMPLATE
ARG SCK_PUBLIC_EXPORT_TEMPLATE
ARG SCK_EXPORT_FOLDER
ARG SCK_REPORT_PROVIDER
ARG SCK_REPORT_SUPPORT_MAIL
ARG SCK_SUPER_ADMIN
ARG SCK_BING_KEY
ARG SCK_SHAPEFILE_IMPORT_SERVICE_URL
ARG SCK_SHAPEFILE_FOLDER
ARG SCK_SHAPEFILE_TPL_FOLDER
ARG SCK_DOCUMENTATIONFILE_FOLDER
ARG SCK_USER_GUIDE_FOLDER
ARG SCK_ARCHIVE_PROVIDER
ARG SCK_DOCUMENTATION_PROVIDER
ARG SCK_TEMPLATE_PROVIDER
ARG SCK_USER_GUIDE_PROVIDER
ARG SCK_BENEFICIARY_FEATURE_LAYER_URL
ARG SCK_BENEFICIARY_PUBLIC_LAYER
ARG SCK_ARCGIS_PROXY
ARG SCK_SPATIAL_REFERENCE
ARG SCK_BACKGROUND_LAYER
ARG mail.smtp.host
ARG mail.smtp.user
ARG SCK_MAIL_SMTP_PASSWORD
ARG SCK_MAIL_STMP_FROM_FOR_BENEF
ARG SCK_MAIL_OUTCOPY
ARG SCK_MAIL_QC
ARG SCK_TABLE_PREFIX
ARG SCK_LPD_WEB_APPLICATION
ARG SCK_AUTH
ARG SCK_LDAP_URL
ARG SCK_LDAP_UID
ARG SCK_LDAP_BASE_CONTEXT
ARG SCK_BENEFICIARY_ACCESS_ACTIVATION_TOKEN_VALIDITY
ARG SCK_BENEFICIARY_ACCESS_VALIDITY
ARG LPD_PRINT_SERVICE
ARG LPD_EXTRACT_SPATIAL_DATA_SERVICE
ARG LPD_SEARCH_LAYER
ARG connection-url
#ARG driver
ARG username
ARG password

#RUN echo $SCK_PRIVATE_EXPORT_TEMPLATE 
#RUN echo $SCK_PUBLIC_EXPORT_TEMPLATE 
#RUN echo $SCK_EXPORT_FOLDER 
#RUN echo $SCK_REPORT_PROVIDER 
#RUN echo $SCK_REPORT_SUPPORT_MAIL 
#RUN echo $SCK_SUPER_ADMIN 
#RUN echo $SCK_BING_KEY 
#RUN echo $SCK_SHAPEFILE_IMPORT_SERVICE_URL 
#RUN echo $SCK_SHAPEFILE_FOLDER 
#RUN echo $SCK_SHAPEFILE_TPL_FOLDER 
#RUN echo $SCK_DOCUMENTATIONFILE_FOLDER 
#RUN echo $SCK_USER_GUIDE_FOLDER 
#RUN echo $SCK_ARCHIVE_PROVIDER 
#RUN echo $SCK_DOCUMENTATION_PROVIDER 
#RUN echo $SCK_TEMPLATE_PROVIDER 
#RUN echo $SCK_USER_GUIDE_PROVIDER 
#RUN echo $SCK_BENEFICIARY_FEATURE_LAYER_URL 
#RUN echo $SCK_BENEFICIARY_PUBLIC_LAYER 
#RUN echo $SCK_ARCGIS_PROXY 
#RUN echo $SCK_SPATIAL_REFERENCE 
#RUN echo $SCK_BACKGROUND_LAYER 
#RUN echo $SCK_MAIL_SMTP_PASSWORD 
#RUN echo $SCK_MAIL_STMP_FROM_FOR_BENEF 
#RUN echo $SCK_MAIL_OUTCOPY 
#RUN echo $SCK_MAIL_QC 
#RUN echo $SCK_TABLE_PREFIX 
#RUN echo $SCK_LPD_WEB_APPLICATION 
#RUN echo $SCK_AUTH 
#RUN echo $SCK_LDAP_URL 
#RUN echo $SCK_LDAP_UID 
#RUN echo $SCK_LDAP_BASE_CONTEXT 
#RUN echo $SCK_BENEFICIARY_ACCESS_ACTIVATION_TOKEN_VALIDITY 
#RUN echo $SCK_BENEFICIARY_ACCESS_VALIDITY 
#RUN echo $LPD_PRINT_SERVICE 
#RUN echo $LPD_EXTRACT_SPATIAL_DATA_SERVICE 
#RUN echo $LPD_SEARCH_LAYER

# Execute system update
RUN apt-get -y update && apt-get clean all

RUN apt-get -y install pwgen wget xmlstarlet bsdtar unzip && apt-get clean all

# Create a user and group used to launch processes
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
RUN groupadd -r jboss -g 1000 && useradd -u 1000 -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss

# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss


ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV JBOSS_HOME /opt/jboss/jboss-as-7.1.1.Final

#Get JBoss 7.1.1 from Jboss.org and unzip it
RUN wget http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.zip
RUN unzip jboss-as-7.1.1.Final.zip

#RUN sed -i -r 's/jboss.bind.address.management:127.0.0.1/jboss.bind.address.management:0.0.0.0/' /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml

#ADD mgmt-users.properties /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/mgmt-users.properties
#ADD mgmt-users.properties /opt/jboss/jboss-as-7.1.1.Final/domain/configuration/mgmt-users.properties
RUN rm -rf /opt/jboss/jboss-as-7.1.1.Final/jboss-modules.jar

COPY jboss-modules-1.1.5.GA.jar /opt/jboss/jboss-as-7.1.1.Final/jboss-modules.jar
COPY JbossWindowsToDocker/jboss/private /opt/jboss/jboss-as-7.1.1.Final/private
COPY JbossWindowsToDocker/jboss/modules /opt/jboss/jboss-as-7.1.1.Final/modules
COPY JbossWindowsToDocker/jboss/standalone/deployments /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments
COPY JbossWindowsToDocker/jboss/standalone/configuration /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration  
RUN rm -rf /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone_xml_history/current

RUN > /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties

RUN wc -l /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties

RUN echo SCK_PRIVATE_EXPORT_TEMPLATE=$SCK_PRIVATE_EXPORT_TEMPLATE >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_PUBLIC_EXPORT_TEMPLATE=$SCK_PUBLIC_EXPORT_TEMPLATE >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_EXPORT_FOLDER=$SCK_EXPORT_FOLDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_REPORT_PROVIDER=$SCK_REPORT_PROVIDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_REPORT_SUPPORT_MAIL=$SCK_REPORT_SUPPORT_MAIL >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_SUPER_ADMIN=$SCK_SUPER_ADMIN >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_BING_KEY=$SCK_BING_KEY >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_SHAPEFILE_IMPORT_SERVICE_URL=$SCK_SHAPEFILE_IMPORT_SERVICE_URL >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_SHAPEFILE_FOLDER=$SCK_SHAPEFILE_FOLDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_SHAPEFILE_TPL_FOLDER=$SCK_SHAPEFILE_TPL_FOLDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_DOCUMENTATIONFILE_FOLDER=$SCK_DOCUMENTATIONFILE_FOLDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_USER_GUIDE_FOLDER=$SCK_USER_GUIDE_FOLDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_ARCHIVE_PROVIDER=$SCK_ARCHIVE_PROVIDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_DOCUMENTATION_PROVIDER=$SCK_DOCUMENTATION_PROVIDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_TEMPLATE_PROVIDER=$SCK_TEMPLATE_PROVIDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_USER_GUIDE_PROVIDER=$SCK_USER_GUIDE_PROVIDER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_BENEFICIARY_FEATURE_LAYER_URL=$SCK_BENEFICIARY_FEATURE_LAYER_URL >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_BENEFICIARY_PUBLIC_LAYER=$SCK_BENEFICIARY_PUBLIC_LAYER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_ARCGIS_PROXY=$SCK_ARCGIS_PROXY >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_SPATIAL_REFERENCE=$SCK_SPATIAL_REFERENCE >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_BACKGROUND_LAYER=$SCK_BACKGROUND_LAYER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo mail.smtp.host=$mail.smtp.host >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo mail.smtp.user=$mail.smtp.user >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_MAIL_SMTP_PASSWORD=$SCK_MAIL_SMTP_PASSWORD >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_MAIL_STMP_FROM_FOR_BENEF=$SCK_MAIL_STMP_FROM_FOR_BENEF >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_MAIL_OUTCOPY=$SCK_MAIL_OUTCOPY >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_MAIL_QC=$SCK_MAIL_QC >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_TABLE_PREFIX=$SCK_TABLE_PREFIX >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_LPD_WEB_APPLICATION=$SCK_LPD_WEB_APPLICATION >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_AUTH=$SCK_AUTH >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_LDAP_URL=$SCK_LDAP_URL >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_LDAP_UID=$SCK_LDAP_UID >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_LDAP_BASE_CONTEXT=$SCK_LDAP_BASE_CONTEXT >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_BENEFICIARY_ACCESS_ACTIVATION_TOKEN_VALIDITY=$SCK_BENEFICIARY_ACCESS_ACTIVATION_TOKEN_VALIDITY >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo SCK_BENEFICIARY_ACCESS_VALIDITY=$SCK_BENEFICIARY_ACCESS_VALIDITY >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo LPD_PRINT_SERVICE=$LPD_PRINT_SERVICE >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo LPD_EXTRACT_SPATIAL_DATA_SERVICE=$LPD_EXTRACT_SPATIAL_DATA_SERVICE >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties
RUN echo LPD_SEARCH_LAYER=$LPD_SEARCH_LAYER >> /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties


RUN wc -l /opt/jboss/jboss-as-7.1.1.Final/standalone/deployments/lpd_web.properties

RUN sed -i 's/jdbc:sqlserver:\/\/LIONFISH;databaseName=lpd_production;integratedSecurity=true/$connection-url/g' /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml
RUN sed -i 's/dbuser/$username/g' /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml
RUN sed -i 's/dbpass/$password/g' /opt/jboss/jboss-as-7.1.1.Final/standalone/configuration/standalone.xml

# Expose the ports we're interested in, 8080 for webinterface and 9990 for Admin Console.
EXPOSE 8080 9990 

# Set the default command to run on boot
# # This will boot JBoss in the standalone mode and bind to all interface
CMD ["/opt/jboss/jboss-as-7.1.1.Final/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement 0.0.0.0"]
