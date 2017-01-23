#!/bin/bash

SECRET_MYSQL_SERVER="${FAF_DB_1_PORT_3306_TCP_ADDR}"
sed -i "s/%SECRET_MYSQL_SERVER%/${SECRET_MYSQL_SERVER}/" /home/unreal/unrealircd/services/conf/services.conf

while true
do
if pgrep -f services 1> /dev/null;then
	sleep 1
else
        echo SERVER CRASHED
        /home/unreal/unrealircd/services/bin/services -nofork -debug
fi
done
