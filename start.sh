#!/bin/sh

if [ -z "$UPSTREAM_SERVER" ]; then
	echo "UPSTREAM_SERVER environment variable is required."
	exit 1
fi

NGINX_CONFIG_FILE="/etc/nginx/nginx.conf"
sed -i "s|{{UPSTREAM_SERVER}}|$UPSTREAM_SERVER|g" "$NGINX_CONFIG_FILE"

exec nginx -g "daemon off;"
