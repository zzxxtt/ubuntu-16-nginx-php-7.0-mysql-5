FROM 1and1internet/ubuntu-16-nginx-1.10.0:latest
MAINTAINER james.eckersall@fasthosts.co.uk
ARG DEBIAN_FRONTEND=noninteractive
COPY files /
RUN \
    apt-get update && \
    apt-get install -y php7.0-cli php7.0-fpm php7.0-common php7.0-curl php7.0-gd php7.0-mysql php7.0-sqlite3 php7.0-xml php7.0-zip php7.0-gettext php7.0-mbstring && \
    mkdir /tmp/composer/ && \
    cd /tmp/composer && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod a+x /usr/local/bin/composer && \
    cd / && \
    rm -rf /tmp/composer && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /etc/nginx/sites-enabled/default /etc/nginx/sites-available/* && \
    sed -i -e 's/^user = www-data$/;user = www-data/g' /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i -e 's/^group = www-data$/;group = www-data/g' /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i -e 's/^listen.owner = www-data$/;listen.owner = www-data/g' /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i -e 's/^listen.group = www-data$/;listen.group = www-data/g' /etc/php/7.0/fpm/pool.d/www.conf && \
    mkdir --mode 777 /var/run/php && \
    chmod 755 /hooks /var/www && \
    chmod -R 777 /var/www/html /var/log

EXPOSE 8080
