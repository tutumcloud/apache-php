FROM ubuntu:latest
MAINTAINER Fernando Mayo <fernando@tutum.co>
RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git apache2 libapache2-mod-php5 php5-mysql
ADD ./start.sh /start.sh
ADD ./supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
RUN chmod 755 /start.sh
