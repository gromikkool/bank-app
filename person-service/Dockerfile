#Stage 1: Build the application
FROM gradle:8.5-jdk21 AS build

ARG NEXUS_URL
ENV NEXUS_URL=$NEXUS_URL

ARG NEXUS_USERNAME
ENV NEXUS_USERNAME=$NEXUS_USERNAME

ARG NEXUS_PASSWORD
ENV NEXUS_PASSWORD=$NEXUS_PASSWORD

WORKDIR /app

COPY . .
RUN ./gradlew clean build -x test

#Stage 2: Create the Docker Image
FROM openjdk:21-jdk-slim
WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5006", "-jar", "app.jar"]
