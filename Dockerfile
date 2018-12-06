FROM openjdk:8
WORKDIR /webapp
VOLUME ["/webapp"]
ADD target/RestMessageAPI.jar RestMessageAPI.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","RestMessageAPI.jar"]
