#!/bin/bash
chown www-data:www-data /app -R

if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi

source /etc/apache2/envvars
tail -F /var/log/apache2/* &

exec apache2 &
sleep 3
exec cron start &
sleep 3
echo "generate certs"
echo "y" | certbot-auto --apache -d ${DOMAIN} -w /var/www/html -n ${STAGING} --agree-tos --email admin@company.com
wait
