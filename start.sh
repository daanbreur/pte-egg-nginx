#!/bin/ash
cd /home/container
rm -rf /home/container/tmp/*

echo "$SERVER_IP:$SERVER_PORT"

cd /home/container/webroot
if [ ! -z ${COMPOSER_MODULES} ]; then 
  composer require ${COMPOSER_MODULES} --working-dir=/home/container/webroot; 
fi;

if [ -d .git ] && [ "${AUTO_UPDATE}" == "1" ]; then
  echo "⟳ Pulling Git..."
  git fetch --all; git reset --hard origin/${BRANCH};
  echo "✓ Successfully synced git"
fi
cd /home/container

echo "⟳ Starting PHP-FPM..."
/usr/sbin/php-fpm8 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize

echo "⟳ Starting Nginx..."
echo "✓ Successfully started"
/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/

