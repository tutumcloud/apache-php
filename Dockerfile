FROM ubuntu:trusty                                                                                                     
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install packages
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install \
        supervisor \
        git \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-gd \
        php-pear \
        php-apc \
        curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

# Add image configuration and scripts
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf

# Configure /app folder with sample app
RUN git clone https://github.com/fermayo/hello-world-php.git /app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

EXPOSE 80
cmd ["supervisord", "-n"]
