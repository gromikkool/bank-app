#Stage 1: Build the application
FROM gradle:8.5-jdk21 AS build
ARG NEXUS_URL
ENV NEXUS_URL=$NEXUS_URL
WORKDIR /app

COPY . .
RUN gradle clean build -x test

#Stage 2: Create the Docker Image
FROM openjdk:21-jdk-slim
WORKDIR /app

EXPOSE 8092
EXPOSE 5005

COPY --from=build /app/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005", "-jar", "app.jar"]

#FROM openjdk:21-jdk-slim
#WORKDIR /app
#
#COPY /build/libs/*.jar app.jar
#
#ENTRYPOINT ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5006", "-jar", "app.jar"]
