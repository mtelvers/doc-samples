#!/bin/sh

set -e

extra_args=""

if [ -z "${OIDC_CRYPTO_PASSPHRASE}" ]; then
  echo "!! Using a temporary random value for OIDC_CRYPTO_PASSPHRASE. Set it explicitly to avoid unnecessary sign-in prompts." >&2
  export OIDC_CRYPTO_PASSPHRASE=$(dd if=/dev/urandom of=/dev/stdout count=100 2>/dev/null | sha256sum - | cut -f 1 -d ' ')
fi

if [ -z "${CLIENT_ID}" ]; then
  echo "!! CLIENT_ID must be set to the application client ID." >&2
  exit 1
fi

if [ -z "${CLIENT_SECRET}" ]; then
  echo "!! CLIENT_SECRET must be set to the application client secret." >&2
  exit 1
fi

if [ -z "${SERVER_NAME}" ]; then
  echo "!! SERVER_NAME must be set to the FQDN for the server." >&2
  exit 1
fi

if [ -z "${REQUIRED_DOMAIN}" ]; then
  export REQUIRED_DOMAIN=cam.ac.uk
fi
echo "-- Users must be part of the "${REQUIRED_DOMAIN}" Google domain." >&2

echo "-- Starting apache"
exec /usr/sbin/apachectl -D FOREGROUND ${extra_args}
