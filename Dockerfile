#FROM openjdk:8-jdk-alpine(praveens base image)
FROM eclipse-temurin:8-jdk
WORKDIR /app
COPY ./target/*.jar /app.jar
CMD ["java", "-jar", "/app.jar"]
