#!/bin/sh

set -e

shib_key="/etc/shibboleth/keys/sp-key.pem"
if [ ! -f "${shib_key}" ]; then
  echo "-- Generating new shib key."
  shib-keygen -o /etc/shibboleth/keys
else
  echo "-- Using existing shib key."
fi

service cron start
certbot run --apache --non-interactive --no-self-upgrade --agree-tos --email $LETS_ENCRYPT_EMAIL --domain $LETS_ENCRYPT_DOMAIN
apachectl stop

extra_args=""

if [ -z "${ENTITY_ID}" ]; then
  echo "!! ENTITY_ID should be set to some non-secret unique name for your site." >&2
  exit 1
fi

if [ -z "${SERVER_NAME}" ]; then
  echo "!! SERVER_NAME should be set to the FQDN for the server. Using localhost." >&2
  export SERVER_NAME=localhost
fi

if [ -z "${SITE_ADMIN_EMAIL}" ]; then
  echo "!! SITE_ADMIN_EMAIL should be set to the webmasters email address." >&2
  export SITE_ADMIN_EMAIL=admin@example.com
fi

envsubst < "/etc/shibboleth/shibboleth2.xml.template" > "/etc/shibboleth/shibboleth2.xml"

adduser -- _shibd ssl-cert

echo "-- Starting shibd"
service shibd start

echo "-- Starting apache"
rm -f /var/run/apache2/apache2.pid
exec /usr/sbin/apachectl -D FOREGROUND ${extra_args}
