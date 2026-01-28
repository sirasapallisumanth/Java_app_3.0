#FROM openjdk:8-jdk-alpine(praveens base image)
FROM openjdk:17-jdk-alpine
WORKDIR /app
COPY ./target/*.jar /app.jar
CMD ["java", "-jar", "/app.jar"]
