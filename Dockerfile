#
# Build stage
#
FROM maven:3.8.3-openjdk-17  AS build
COPY src ./src
COPY pom.xml .
RUN mvn -f ./pom.xml clean package -DskipTests

#
# Package stage
#
FROM openjdk:17-alpine
WORKDIR /Sentryc-app
MAINTAINER djain
VOLUME /sentryc-app-vol
EXPOSE 9292
COPY --from=build ./target/sentrycapp.jar /usr/local/lib/sentrycapp.jar
ENTRYPOINT ["java", "-jar", "/usr/local/lib/sentrycapp.jar"]