FROM java:8-jre
MAINTAINER yannick.houbrix@gmail.com

ENV HUB_PORT 8080
ENV HUB_VERSION 2.0
ENV HUB_BUILD 244
ENV HUB_DIST_NAME hub-ring-bundle-${HUB_VERSION}.${HUB_BUILD}
ENV HUB_DIST ${HUB_DIST_NAME}.zip
ENV HUB_DIST_URL https://download.jetbrains.com/hub/${HUB_VERSION}/${HUB_DIST}
ENV HUB_HOME /opt/hub

WORKDIR ${HUB_HOME}

RUN wget --progress=dot:mega ${HUB_DIST_URL} -O ${HUB_DIST}
RUN unzip ${HUB_DIST} -d .

WORKDIR ${HUB_HOME}/${HUB_DIST_NAME}

RUN bin/hub.sh configure \
    --backups-dir ${HUB_HOME}/backups \
    --data-dir    ${HUB_HOME}/data \
    --logs-dir    ${HUB_HOME}/log \
    --temp-dir    ${HUB_HOME}/tmp \
    --listen-port $HUB_PORT \
    --base-url    http://localhost/

ENTRYPOINT ["bin/hub.sh"]
CMD ["run"]
EXPOSE $HUB_PORT
VOLUME ["${HUB_HOME}/backups", "${HUB_HOME}/data", "${HUB_HOME}/log", "${HUB_HOME}/tmp"]
