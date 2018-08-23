FROM openjdk:8-jre-alpine

MAINTAINER Jeromy Van Dusen <jeromy.vandusen@gmail.com>

ENV SERVER_PORT=8080
ENV DEBUG_PORT=8000
ENV JAR_FILE ${JAR_FILE}

VOLUME /tmp

COPY entrypoint.sh /app/entrypoint.sh

RUN chmod 755 /app/entrypoint.sh && sh -c 'touch /app/${JAR_FILE}'

EXPOSE ${SERVER_PORT}
EXPOSE ${DEBUG_PORT}

WORKDIR /app

RUN apk --no-cache add curl

ONBUILD ADD target/${JAR_FILE} /app/app.jar

HEALTHCHECK CMD curl -v --fail http://localhost:${SERVER_PORT}/actuator/health || exit 1

ENTRYPOINT ["./entrypoint.sh"]
