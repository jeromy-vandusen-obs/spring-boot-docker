FROM openjdk:8-jre-alpine

MAINTAINER Jeromy Van Dusen <jeromy.vandusen@gmail.com>

ENV SERVER_PORT=8080
ENV DEBUG_PORT=8000
ENV APP_HOME=/app

VOLUME /tmp

COPY entrypoint.sh $APP_HOME/entrypoint.sh

RUN chmod 755 $APP_HOME/entrypoint.sh && sh -c 'touch $APP_HOME/app.jar'

EXPOSE $SERVER_PORT
EXPOSE $DEBUG_PORT

WORKDIR $APP_HOME

RUN apk --no-cache add curl

HEALTHCHECK CMD curl -v --fail http://localhost:$SERVER_PORT/actuator/health || exit 1

ENTRYPOINT ["./entrypoint.sh"]
