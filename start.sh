#!/bin/sh

if [ -z "$UPSTREAM_SERVER" ]; then
	echo "UPSTREAM_SERVER environment variable is required."
	exit 1
fi

if [ -z "$IDLE_TIMEOUT_SECONDS" ]; then
	echo "IDLE_TIMEOUT_SECONDS environment variable is required."
	exit 1
fi

NGINX_CONFIG_FILE="/etc/nginx/nginx.conf"
TIMER_FILE="/etc/nginx/timer.lua"

sed -i "s|{{UPSTREAM_SERVER}}|$UPSTREAM_SERVER|g" "$NGINX_CONFIG_FILE"
sed -i "s|{{IDLE_TIMEOUT_SECONDS}}|$IDLE_TIMEOUT_SECONDS|g" "$TIMER_FILE"

exec nginx -g "daemon off;"
