FROM maven:3.3-jdk-8 as maven-builder
ARG TEST=/var/lib
WORKDIR $TEST
COPY ./hello-world-war .
RUN mvn clean install

FROM tomcat:9.0
ARG TEST=/var/lib
COPY --from=maven-builder ${TEST}/target/hello-world-war-1.0.0.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh", "run"]
