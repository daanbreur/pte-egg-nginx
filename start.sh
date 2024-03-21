#!/bin/ash
rm -rf /home/container/tmp/*

# I will fix l8r tm
# if [[ -d .git ]] && [[ $AUTO_UPDATE == "1" ]]; then
cd /home/container/webroot
echo "⟳ Pulling Git..."
git fetch --all; git reset --hard origin/master;
echo "✓ Successfully synced git"
# fi

echo "⟳ Starting PHP-FPM..."
/usr/sbin/php-fpm8 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize

echo "⟳ Starting Nginx..."
echo "✓ Successfully started"
/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/
