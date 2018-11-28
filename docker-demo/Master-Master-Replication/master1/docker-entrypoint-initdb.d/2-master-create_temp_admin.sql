USE mysql;
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'temp';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';
FLUSH PRIVILEGES;