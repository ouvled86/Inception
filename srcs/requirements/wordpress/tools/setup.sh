#!/bin/bash
set -e

while ! mariadb -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "status" > /dev/null 2>&1; do
    sleep 1
done

# Remove stale Redis password config from earlier setups before running WP-CLI.
if [ -f "/var/www/html/wp-config.php" ]; then
    sed -i '/WP_REDIS_PASSWORD/d' /var/www/html/wp-config.php || true
fi
rm -f /var/www/html/wp-content/object-cache.php

if [ ! -f "/var/www/html/wp-config.php" ]; then
    wp core download --path=/var/www/html --allow-root
    wp config create --path=/var/www/html --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=mariadb --allow-root
    wp core install --path=/var/www/html --url=${DOMAIN_NAME} --title="${WP_TITLE}" --admin_user=${WP_ADMIN_USER} --admin_password=${WP_ADMIN_PASSWORD} --admin_email=${WP_ADMIN_EMAIL} --skip-email --allow-root
    wp user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --role=author --path=/var/www/html --allow-root
fi

if wp core is-installed --path=/var/www/html --allow-root; then
    wp option update home "https://${DOMAIN_NAME}" --path=/var/www/html --allow-root
    wp option update siteurl "https://${DOMAIN_NAME}" --path=/var/www/html --allow-root

    if ! wp plugin is-installed redis-cache --path=/var/www/html --allow-root; then
        wp plugin install redis-cache --path=/var/www/html --allow-root
    fi
    wp plugin activate redis-cache --path=/var/www/html --allow-root
    wp config set WP_REDIS_HOST "${REDIS_HOST}" --path=/var/www/html --allow-root
    wp config set WP_REDIS_PORT "${REDIS_PORT}" --raw --path=/var/www/html --allow-root
    wp redis enable --path=/var/www/html --allow-root || true
fi

if [ -d "/usr/local/share/inception-static" ]; then
    mkdir -p /var/www/html/wp-content/themes/inception-static
    cp -R /usr/local/share/inception-static/* /var/www/html/wp-content/themes/inception-static/
    if wp core is-installed --path=/var/www/html --allow-root; then
        wp theme activate inception-static --path=/var/www/html --allow-root || true
    fi
fi

exec "$@"
