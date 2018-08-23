#!/bin/sh

if [ "$DEBUG" = true ]; then
  JAVA_OPTS="$JAVA_OPTS -Xdebug -Xrunjdwp:server=y,transport=dt_socket,address=$DEBUG_PORT,suspend=n"
fi

exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar app/$JAR_FILE
