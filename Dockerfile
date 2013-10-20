FROM ubuntu:latest
MAINTAINER Fernando Mayo <fernando@tutum.co>

# Install packages
RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git apache2 libapache2-mod-php5 php5-mysql

# Add image configuration and scripts
ADD ./start.sh /start.sh
ADD ./supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
RUN chmod 755 /start.sh

# Configure /app folder
RUN mkdir -p /app
RUN rm -fr /var/www
RUN ln -s /app /var/www
