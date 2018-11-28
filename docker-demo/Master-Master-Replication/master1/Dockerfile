ARG MYSQL_VERSION=latest
FROM mysql:${MYSQL_VERSION}

LABEL maintainer="Scott Lin <youdontsay@al.carrer>"

#####################################
# Set Timezone
#####################################

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && chown -R mysql:root /var/lib/mysql/

COPY my.cnf /etc/mysql/conf.d/my.cnf

RUN apt-get update && apt-get --no-install-recommends --no-install-suggests -y install expect
COPY mysql_login_config.sh /root/mysql_login_config.sh

ARG MASTER_ROOT_PASSWORD=root
ENV MASTER_ROOT_PASSWORD ${MASTER_ROOT_PASSWORD}
RUN cd /root && ./mysql_login_config.sh root $MASTER_ROOT_PASSWORD

CMD ["mysqld"]

EXPOSE 3306
