CREATE TABLE IF NOT EXISTS `persons` (
    id int NOT NULL AUTO_INCREMENT,
    last_name varchar(255) NOT NULL,
    middle_name varchar(255),
    first_name varchar(255),
    PRIMARY KEY (id)
);
