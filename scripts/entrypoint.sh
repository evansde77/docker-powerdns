#!/bin/bash
set -e


if [[ "x"$MYSQL_HOST == "x" ]]; then
		export MYSQL_HOST='db'
fi


if [[ "x"$MYSQL_USER != "x" && "x"$MYSQL_PASSWORD != "x" && "x"$MYSQL_DATABASE != "x" ]]; then
		echo >&2 "Parameters detected"

		export PARAM_MYSQLOK=`mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} --password=${MYSQL_PASSWORD} -e "show databases;"|grep -o "Database"`
		export PARAM_MYSQLDBOK=`mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} --password=${MYSQL_PASSWORD} -e "show databases;"|grep -o "${MYSQL_DATABASE}"`

		if [ "$PARAM_MYSQLOK" != "Database" ]; then
				echo >&2 "Failed to connect to Database"
				exit 1
		fi

		if [[ "$PARAM_MYSQLOK" != "$MYSQL_DATABASE" ]]; then
				echo >&2 "Initialising DB"
				sed -i -e "s:\[dbname\]:${MYSQL_DATABASE}:g" /sql/init.sql
				mysql -h $MYSQL_HOST -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE < /sql/init.sql
				mysql -h $MYSQL_HOST -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE < /sql/index.sql &
		fi

		#echo "gmysql-host=$MYSQL_HOST" > /etc/powerdns/pdns.d/pdns.local
		#echo "gmysql-user=$MYSQL_USER" >> /etc/powerdns/pdns.d/pdns.local
		#echo "gmysql-password=$MYSQL_PASSWORD" >> /etc/powerdns/pdns.d/pdns.local
		#echo "gmysql-dbname=$MYSQL_DATABASE" >> /etc/powerdns/pdns.d/pdns.local

		#sed -i -e "s/# webserver=no/webserver=yes/g"  /etc/powerdns/pdns.conf
		#sed -i -e "s/# webserver-address=127.0.0.1/webserver-address=0.0.0.0/g"  /etc/powerdns/pdns.conf
		#sed -i -e "s/# webserver-port=8081/webserver-port=80/g"  /etc/powerdns/pdns.conf
		#sed -i -e "s/# launch=/launch=gmysql/g"  /etc/powerdns/pdns.conf
fi


exec "$@"
