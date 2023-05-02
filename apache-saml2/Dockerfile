FROM debian:bullseye

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y apache2 ssl-cert gettext-base libapache2-mod-shib \
    && a2enmod include rewrite ssl shib headers \
    && a2dissite 000-default \
    && apt-get autoclean \
    && mkdir -p /etc/shibboleth/keys

ADD entrypoint.sh /usr/local/bin
ADD ./sites/ /etc/apache2/sites-enabled/
ADD ./shib/ /etc/shibboleth/
ADD ./conf/ /etc/apache2/conf-enabled/
ADD ./htdocs/ /var/www/protected/

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid

ENV IDP_METADATA_CACHE_FILE ucamfederation-idp-metadata-cache.xml

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
