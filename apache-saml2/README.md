# Simple Shibboleth Proxy

This container provides a basic Apache configuration which demonstrates
protecting a site running on the Apache web server with Raven SAML 2.0.

## Example

You will need to choose an *entity id* which needs to uniquely identify your
site.

```bash
$ export ENTITY_ID="Some human-friendly description of your site"
$ docker run --rm -it \
    -e ENTITY_ID -v shib-keys:/etc/shibboleth/keys -p 8000:80 \
    registry.gitlab.developers.cam.ac.uk/uis/devops/raven/doc-samples/apache-saml2
```

> Before the site will function, the SAML metadata needs to be added to the
> Raven metadata application. See the [metadata](#Metadata) section below.

## Configuration

The following environment variables are used for configuration:

* ENTITY_ID (required) - Unique public string identifying site.
* SERVER_NAME (optional) - Fully-qualified domain name of site.
* SITE_ADMIN_EMAIL (optional) - The email address that will be included in any error messages

## Replicated deployment

For convenience, the container generates a random key pair used to encrypt the
shibboleth traffic if one is not specified. This keypair should be stored in a
docker volume to prevent needing to re-register the metadata every time the
container re-spawns. For a replicated deployment, you will want to use the same
key pair for each replica.

## Metadata

Once the container is running for the first time visit
http://localhost:8000/Shibboleth.sso/Metadata to download your metadata.  Then
upload this to https://metadata.raven.cam.ac.uk/
