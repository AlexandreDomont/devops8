#!/bin/bash

HASH=$(</root/www-data.txt) 
printf "www-data:$HASH" | chpasswd --encrypted

service mysql start && /etc/init.d/ssh start && service php7.0-fpm start && apache2ctl -D FOREGROUND


