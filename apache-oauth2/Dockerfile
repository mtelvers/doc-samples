FROM ubuntu:18.04

RUN set -e; \
  apt-get update -y; \
  apt-get upgrade -y; \
  apt-get install -y \
    vim wget apache2 libssl1.0.0 libapache2-mod-auth-openidc; \
  a2enmod proxy proxy_connect proxy_http rewrite ssl auth_openidc \
    include headers; \
  a2dissite 000-default; \
  apt-get autoclean;

ADD entrypoint.sh /usr/local/bin
ADD ./sites/ /etc/apache2/sites-enabled/
ADD ./conf/ /etc/apache2/conf-enabled/
ADD ./htdocs/ /var/www/protected/

ENV APACHE_RUN_USER=www-data \
	APACHE_RUN_GROUP=www-data \
	APACHE_LOG_DIR=/var/log/apache2 \
	APACHE_LOCK_DIR=/var/lock/apache2 \
	APACHE_PID_FILE=/var/run/apache2.pid \
	SERVER_NAME=localhost \
	REDIRECT_URI=/.oidc/redirect

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
