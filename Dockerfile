FROM ubuntu:trusty
MAINTAINER Lorenz Vanthillo <lorenz.vanthillo@outlook.com> 

# Install base packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        curl \
        wget \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-mcrypt \
        php5-gd \
        php5-curl \
        php-pear \
        php-apc && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN /usr/sbin/php5enmod mcrypt
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

ENV ALLOW_OVERRIDE **False**

# Add cron script to renew certs
ADD cron/crontab /etc/
RUN rm -r /etc/cron.weekly/
ADD cron/update /etc/cron.weekly/
RUN chmod +x /etc/cron.weekly/update


# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
ADD sample/ /app

# Configure letsencrypt
RUN cd /usr/local/sbin && \
    wget https://dl.eff.org/certbot-auto
RUN chmod a+x /usr/local/sbin/certbot-auto

EXPOSE 443

CMD ["/run.sh"]
