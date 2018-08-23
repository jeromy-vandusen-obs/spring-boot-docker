# Spring Boot Docker

A lightweight base image for Spring Boot applications. This image is based on a similar image created by Florian Lopes
(https://github.com/f-lopes/spring-boot-docker/tree/healthcheck). It has been simplified a bit so that it is not as
flexible, but instead enforces some standards that I prefer to use in my Spring Boot applications.

## Docker Hub

The built image can be found on Docker Hub (https://hub.docker.com/r/jvandusen/spring-boot-docker/).

## Environment Variables

Name        | Default | Description
------------|---------|----------------------------------------------------------------------------------------------
DEBUG       | false   | Enable/disable debug mode. Disabled by default.
DEBUG_PORT  | 8000    | Port used for debug mode, if enabled. When debug mode is disabled, this setting does nothing.
JAVA_OPTS   |         | Java options that will be used when launching the Spring Boot application in the container.
SERVER_PORT | 8080    | Port that the Spring Boot application listens on.

## Usage

To create an image for a Spring Boot application based on this image, your Dockerfile should look something like this:

```
FROM jvandusen/spring-boot-docker:latest

ENV JAR_FILE my-app-1.0.0.jar
```

Then build your image using the standard Docker command:

```
docker build -t my-image-name .
```

To launch a container using your new image with all defaults:

```
docker run -d -p 8080:8080 my-image-name
```

To launch a container using your new image in debug mode with all other defaults:

```
docker run -d -p 8080:8080 -p 8000:8000 -e DEBUG=true my-image-name
```

To launch a container using your new image with the application listening on port 8888, debug mode enabled and listening on port
9000, and additional JVM options "-Xmx512m":

```
docker run -d -p 8888:8888 -p 9000:9000 -e DEBUG=true -e DEBUG_PORT=9000 -e JAVA_OPTS=-Xmx512m -e SERVER_PORT=8888 my-image-name
```
