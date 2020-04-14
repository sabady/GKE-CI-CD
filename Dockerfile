# webapp Dockerfile
FROM openjdk:8-alpine
COPY **/*.jar /webapp.jar
CMD ["java", "-jar", "/webapp.jar"]