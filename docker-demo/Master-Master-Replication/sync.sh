#!/bin/bash

# docker-compose up -d

MASTER_ALPHA_ID="$(docker-compose ps -q master-alpha)"
MASTER_BETA_ID="$(docker-compose ps -q master-beta)"
LOGIN_PATH="admin"

echo "Start configuration..."


echo "############# Setup login credential #############"
echo "Setting for Master-Alpha"
docker exec -it "$MASTER_ALPHA_ID" /root/mysql_login_config.sh $LOGIN_PATH root root
docker exec -it "$MASTER_ALPHA_ID" mysql_config_editor print --all
echo "Setting for Master-Beta"
docker exec -it "$MASTER_BETA_ID" /root/mysql_login_config.sh $LOGIN_PATH root root
docker exec -it "$MASTER_BETA_ID" mysql_config_editor print --all


echo "############# Setup master and slave #############"

echo "Setting for Master-Beta"
docker exec "$MASTER_BETA_ID" mysql "--login-path=$LOGIN_PATH" -e "STOP SLAVE;
CHANGE MASTER TO
  MASTER_HOST='master-alpha',
  MASTER_USER='replica1',
  MASTER_PASSWORD='repliword';
START SLAVE;
"

echo "Setting for Master-Alpha"
docker exec "$MASTER_ALPHA_ID" mysql "--login-path=$LOGIN_PATH" -e "STOP SLAVE;
CHANGE MASTER TO
  MASTER_HOST='master-beta',
  MASTER_USER='replica2',
  MASTER_PASSWORD='repliword';
START SLAVE;
"

echo "############# Create table #############"
docker exec "$MASTER_ALPHA_ID" mysql "--login-path=$LOGIN_PATH" -e "USE prova;
CREATE TABLE IF NOT EXISTS persons (
    id int NOT NULL AUTO_INCREMENT,
    last_name varchar(255) NOT NULL,
    middle_name varchar(255),
    first_name varchar(255),
    PRIMARY KEY (id)
);"