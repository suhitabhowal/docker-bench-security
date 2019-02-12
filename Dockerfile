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

FROM alpine:3.8
LABEL \
  org.label-schema.name="docker-bench-security" \
  org.label-schema.url="https://dockerbench.com" \
  org.label-schema.vcs-url="https://github.com/docker/docker-bench-security.git"

# Switch to the HTTPS endpoint for the apk repositories
# https://github.com/gliderlabs/docker-alpine/issues/184
RUN \
  sed -i 's/http\:\/\/dl-cdn.alpinelinux.org/https\:\/\/alpine.global.ssl.fastly.net/g' /etc/apk/repositories && \
  apk add --no-cache \
    iproute2 \
    docker \
    dumb-init && \
  rm -rf /usr/bin/docker?*

COPY ./*.sh /usr/local/bin/
COPY ./tests/*.sh /usr/local/bin/tests/

HEALTHCHECK CMD exit 0

WORKDIR /usr/local/bin

#ENTRYPOINT [ "/usr/bin/dumb-init", "docker-bench-security.sh" ]
CMD [""]
