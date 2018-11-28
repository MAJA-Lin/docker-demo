#!/bin/bash

# docker-compose up -d

MASTER_ALPHA_ID="$(docker-compose ps -q master-alpha)"
MASTER_BETA_ID="$(docker-compose ps -q master-beta)"

echo "Executing sql scripts..."


echo "Setup master beta"

docker exec "$MASTER_BETA_ID" mysql --login-path=temp_admin -e "STOP SLAVE;
CHANGE MASTER TO
  MASTER_HOST='master-alpha',
  MASTER_USER='replica1',
  MASTER_PASSWORD='repliword';
START SLAVE;
"

echo "Setup master alpha"
docker exec "$MASTER_ALPHA_ID" mysql --login-path=temp_admin -e "STOP SLAVE;
CHANGE MASTER TO
  MASTER_HOST='master-beta',
  MASTER_USER='replica2',
  MASTER_PASSWORD='repliword';
START SLAVE;
"

echo "Create table"
docker exec "$MASTER_ALPHA_ID" mysql --login-path=temp_admin -e "USE prova;
CREATE TABLE IF NOT EXISTS persons (
    id int NOT NULL AUTO_INCREMENT,
    last_name varchar(255) NOT NULL,
    middle_name varchar(255),
    first_name varchar(255),
    PRIMARY KEY (id)
);"