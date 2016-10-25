# apache-php
Docker image to run PHP applications on Apache (with SSH using letsencrypt). 
Letsencrypt provides free and secure certificates.
The container contains a cronjob which recreates the certificates each 7 days.

Info:
- https://letsencrypt.org/
- https://letsencrypt.org/2015/11/09/why-90-days.html

#### Build docker image
```
docker build -t lorenzvth7/apache-php .
```

#### Run the container
```
docker run -d \
-p 443:443 \
-e DOMAIN="www.my-domain.com" \
-e STAGING="--staging" \
--restart=always \
-v /my/local/code:/app/ \
lorenzvth7/apache-php
```

The staging option provides a possibility to test your setup. This will create fake certificates (because you can only ask 5 real certificates each week).
If you want to use the real certificates:

```
docker run -d \
-p 443:443 \
-e DOMAIN="www.my-domain.com" \
--restart=always \
-v /my/local/code:/app/ \
lorenzvth7/apache-php
```
