# webapp Dockerfile
FROM openjdk:8-alpine
COPY ../target/*.jar /webapp.jar
CMD ["java", "-jar", "/webapp.jar"]