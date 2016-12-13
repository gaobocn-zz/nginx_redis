#!/bin/bash

apt-get update
apt-get install build-essential tcl

# download redis
cd /tmp
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz
cd redis-stable
make
make install

# config redis
mkdir -p /etc/redis
cp /tmp/redis-stable/redis.conf /etc/redis
sed -i -E "s/^supervised no$/supervised systemd/g" /etc/redis/redis.conf
sed -i -E "s/^dir .\/$/dir \/var\/lib\/redis/g" /etc/redis/redis.conf
cp ~/nginx_redis/redis_server/redis.service /etc/systemd/system/


adduser --system --group --no-create-home redis
mkdir -p /var/lib/redis
chown redis:redis /var/lib/redis
chmod 774 /var/lib/redis

systemctl start redis
systemctl enable redis
