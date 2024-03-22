#!/bin/ash
rm -rf /home/container/tmp/*

cd /home/container/webroot
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
