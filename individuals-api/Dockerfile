FROM amazoncorretto:21-al2023-jre
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
