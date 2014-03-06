FROM ubuntu:quantal
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install packages
RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor git apache2 libapache2-mod-php5 php5-mysql php5-gd php-pear php-apc curl && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin && mv /usr/local/bin/composer.phar /usr/local/bin/composer

# Add image configuration and scripts
ADD start.sh /start.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf

# Configure /app folder with sample app
RUN git clone https://github.com/fermayo/hello-world-php.git /app
RUN mkdir -p /app && rm -fr /var/www && ln -s /app /var/www

EXPOSE 80
CMD ["/run.sh"]
