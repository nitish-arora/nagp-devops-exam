FROM tomcat:alpine
MAINTAINER nitish
ADD artifactory_url /usr/local/tomcat/webapps/feature.war
EXPOSE 9090
RUN /usr/local/tomcat/bin/catalina.sh run