# syntax = edrevo/dockerfile-plus

INCLUDE+ Dockerfile.base

COPY timer.lua /etc/nginx/timer.lua
COPY nginx.conf /etc/nginx/nginx.conf
COPY shutdown.sh /shutdown.sh
COPY start.sh /start.sh

CMD ["/start.sh"]
