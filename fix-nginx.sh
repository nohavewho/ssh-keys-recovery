#!/bin/bash

# This script is intended to be run after recovering SSH access
# It will check and fix common nginx issues

echo "Checking nginx configuration..."

# Check if nginx is installed
if ! command -v nginx &> /dev/null; then
    echo "nginx is not installed"
    exit 1
fi

# Check if nginx is running
echo "Checking nginx status..."
systemctl status nginx

# Check nginx configuration
echo "Validating nginx configuration..."
nginx -t

# Check for expired domains in nginx configuration
echo "Checking for potentially expired domains in nginx configs..."
SITES_DIR="/etc/nginx/sites-enabled"

if [ -d "$SITES_DIR" ]; then
    for config in $SITES_DIR/*; do
        echo "Checking $config"
        grep -i "server_name" "$config"
    done
else
    echo "No sites-enabled directory found"
fi

echo "Nginx error log:"
tail -20 /var/log/nginx/error.log

echo ""
echo "To fix expired domain issues, you can temporarily disable problematic sites:"
echo "- mv /etc/nginx/sites-enabled/problem-site.conf /etc/nginx/sites-available/"
echo "- systemctl restart nginx"
echo ""
echo "To check for stuck nginx processes:"
echo "- ps aux | grep nginx"
echo "- kill -9 <PID> # to kill stuck processes if needed"
echo ""
echo "To restart nginx with a clean state:"
echo "- systemctl stop nginx"
echo "- killall -9 nginx # if any processes are stuck"
echo "- systemctl start nginx"