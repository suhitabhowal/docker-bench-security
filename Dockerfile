FROM ubuntu:16.04
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y curl && apt-get update && apt-get install -y iputils-ping
RUN apt-get -y install openjdk-8-jdk wget
RUN mkdir /usr/local/tomcat
RUN wget http://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.37/bin/apache-tomcat-8.5.37.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.37/* /usr/local/tomcat/
EXPOSE 8080
ADD target/app.war /usr/local/tomcat/webapps/
CMD /usr/local/tomcat/bin/catalina.sh run
# REPOSITORY https://github.com/fatherlinux/docker-bench-security

FROM centos

MAINTAINER smccarty@redhat.com

RUN yum install -y docker iproute audit procps-ng; yum clean all

RUN mkdir /docker-bench-security

COPY . /docker-bench-security

WORKDIR /docker-bench-security

ENTRYPOINT ["/bin/sh", "docker-bench-security.sh"]
