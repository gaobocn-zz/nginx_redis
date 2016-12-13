#!/bin/bash
set -e
set -x

echo "Provisioning Reverse Proxy on EC2!"

#apt-get update
#apt-get install -y nginx lynx 
./openresty-ubuntu-install.sh

# change buf size
sudo sed -i '/^http {$/ a \\n\tproxy_headers_hash_max_size 2048;\n\tproxy_headers_hash_bucket_size 1024;' /etc/nginx/nginx.conf

#Config NGINX:
ln -s  "$(pwd)/color_count" /etc/nginx/sites-available/
ln -s "$(pwd)/color_count" /etc/nginx/sites-enabled/
sudo rm -rf /etc/nginx/sites-enabled/default
systemctl restart nginx

echo "Provisioning complete!"
