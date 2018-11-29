#!/usr/bin/expect

set login_name [lindex $argv 0];
set username [lindex $argv 1];
set password [lindex $argv 2];

spawn mysql_config_editor set "--login-path=$login_name" --host=localhost "--user=$username" --password
expect -nocase "Enter password:" {send "$password\r"; interact}
