#!/usr/bin/expect

set username [lindex $argv 0];
set password [lindex $argv 1];

spawn mysql_config_editor set --login-path=temp_admin --host=localhost "--user=$username" --password
expect -nocase "Enter password:" {send "$password\r"; interact}
