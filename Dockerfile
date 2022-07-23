FROM openjdk:8-jdk-alpine
COPY target/*.jar docker.jar
ENTRYPOINT ["java","-jar","docker.jar"]


