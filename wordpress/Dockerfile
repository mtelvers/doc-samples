FROM wordpress:5.3

# Copy expected SHA256 checksums of downloaded files into container
ADD ./checksums.txt /tmp/downloads/checksums.txt

# Download, verify and install plugins. Note that the default wordpress image
# actually *copies* wordpress from /usr/src/wordpress
RUN \
  apt-get update -y \
  && apt-get install unzip \
  && cd /tmp/downloads \
  && curl -o daggerhart-openid-connect-generic.zip \
    https://downloads.wordpress.org/plugin/daggerhart-openid-connect-generic.3.5.0.zip \
  && sha256sum -c checksums.txt \
  && mkdir -p /usr/src/wordpress/wp-content/plugins/ \
  && cd /usr/src/wordpress/wp-content/plugins/ \
  && unzip /tmp/downloads/daggerhart-openid-connect-generic.zip \
  && rm -r /tmp/downloads/ \
  && chmod oug+rX /usr/src/wordpress/wp-content/

# vim:sw=2:sts=2:et
