FROM tomcat:alpine
MAINTAINER nitish
ADD http://localhost:8086/artifactory/ /usr/local/tomcat/webapps/feature.war
EXPOSE 8080
RUN /usr/local/tomcat/bin/catalina.sh run