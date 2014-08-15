#!/bin/bash
set -e

# Setting default values
if [[ "x"$MYSQL_HOST == "x" ]]; then
		export MYSQL_HOST='db'
fi

if [[ "x"$WEBSERVER_ADDRESS == "x" ]]; then
		export WEBSERVER_ADDRESS='0.0.0.0'
fi

if [[ "x"$WEBSERVER_PORT == "x" ]]; then
		export WEBSERVER_PORT='80'
fi

if [[ "x"$PDNS_LOCALADDRESS == "x" ]]; then
		export PDNS_LOCALADDRESS='0.0.0.0'
fi

if [[ "x"$PDNS_IPRANGE == "x" ]]; then
		export PDNS_IPRANGE='172.16.0.0/12'
fi

# Basic config
export PARAMS="--no-config --master --daemon=no --local-address=$PDNS_LOCALADDRESS --allow-axfr-ips=$PDNS_IPRANGE"

if [[ "x"$MYSQL_USER != "x" && "x"$MYSQL_PASSWORD != "x" && "x"$MYSQL_DATABASE != "x" ]]; then
	export PARAMS="$PARAMS --launch=gmysql --gmysql-host=$MYSQL_HOST --gmysql-user=$MYSQL_USER --gmysql-password=$MYSQL_PASSWORD --gmysql-dbname=$MYSQL_DATABASE"
fi

if [[ "x"$WEBSERVER != "x" ]]; then
	export PARAMS="$PARAMS  --webserver-address=$WEBSERVER_ADDRESS --webserver-port=$WEBSERVER_PORT --webserver-password=$WEBSERVER_PASSWORD"
fi

# Run
exec /usr/sbin/pdns_server $PARAMS


