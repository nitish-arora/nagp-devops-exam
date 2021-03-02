FROM tomcat:alpine
MAINTAINER nitish
ADD http://localhost:8086/artifactory/nagp-devops-exam/com/nagarro/devops-tools/devops/demosampleapplication/1.0.0-SNAPSHOT/demosampleapplication-1.0.0-SNAPSHOT.war /usr/local/tomcat/webapps/feature.war
EXPOSE 8080
RUN /usr/local/tomcat/bin/catalina.sh run