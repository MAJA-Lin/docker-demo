#!/bin/bash

# docker-compose up -d

MASTER_1_ID="$(docker-compose ps -q master-1)"
MASTER_2_ID="$(docker-compose ps -q master-2)"

echo "Executing sql scripts..."

docker exec "$MASTER_2_ID" mysql --login-path=temp_admin -e "STOP SLAVE;
CHANGE MASTER TO
  MASTER_HOST='master',
  MASTER_USER='replica1',
  MASTER_PASSWORD='repliword';
START SLAVE;
"

docker exec "$MASTER_1_ID" mysql --login-path=temp_admin -e "STOP SLAVE;
CHANGE MASTER TO
  MASTER_HOST='slave',
  MASTER_USER='replica2',
  MASTER_PASSWORD='repliword';
START SLAVE;
"
docker exec "$MASTER_1_ID" mysql --login-path=temp_admin -e "USE prova;
CREATE TABLE IF NOT EXISTS persons (
    id int NOT NULL AUTO_INCREMENT,
    last_name varchar(255) NOT NULL,
    middle_name varchar(255),
    first_name varchar(255),
    PRIMARY KEY (id)
);"