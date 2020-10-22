ARG test1
FROM openjdk:7
MAINTAINER Helias B

RUN echo "test1"


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

# Expose the ports we're interested in, 8080 for webinterface and 9990 for Admin Console.
EXPOSE 8080 9990 

# Set the default command to run on boot
# # This will boot JBoss in the standalone mode and bind to all interface
CMD ["/opt/jboss/jboss-as-7.1.1.Final/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement 0.0.0.0"]
