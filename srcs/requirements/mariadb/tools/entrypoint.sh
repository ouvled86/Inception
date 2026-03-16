#!/bin/bash
set -eu

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    tfile=$(mktemp)
    if [ ! -f "$tfile" ]; then
        exit 1
    fi

    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- Portfolio DB Setup
CREATE DATABASE IF NOT EXISTS portfolio_db;
GRANT ALL PRIVILEGES ON portfolio_db.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    mysqld --user=mysql --bootstrap < $tfile
    
    # Run schema.sql
    if [ -f "/docker-entrypoint-initdb.d/schema.sql" ]; then
        mysqld --user=mysql --bootstrap < /docker-entrypoint-initdb.d/schema.sql
    fi
    rm -f $tfile
fi

exec "$@"
