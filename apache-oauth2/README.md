# Raven OAuth2 and Apache Example

This container provides a basic Apache configuration which demonstrates
protecting a site running on the Apache web server with Raven OAuth2.

## Pre-requisites

You will need to register your application with Google. These steps are
well-documented on the web and Google themselves provide
[documentation](https://developers.google.com/identity/sign-in/web/sign-in) on
how to register an OAuth2 client ID and secret.

You will also need to select a "redirect URI". This is a URI on your server
which should not exist and will instead be claimed by the proxy to receive the
authentication response from Google. A good choice is something like
"https://your-server-hostname/.oidc/redirect_uri" but it doesn't really matter
what it is as long as it doesn't correspond to an existing URL for your
application.

> This redirect URI must match the one set in your OAuth2 application
> configuration in the Google developers' control panel.

## Running

You should create some OAuth2 web application credentials with the following
settings:

* Authorised redirect URL: http://localhost:8000/.oidc/redirect_uri

Record the application client id and secret in the ``CLIENT_ID`` and
``CLIENT_SECRET`` environment variables.

```console
# Prefix these commands with " " to avoid them being recorded in the history.
$  export CLIENT_ID=ABCDEFGHIJKLMN  # replace with value from Google
$  export CLIENT_SECRET=1234567     # replace with value from Google
```

Run the Apache web server:

```console
$ docker run --rm -it -e CLIENT_ID -e CLIENT_SECRET -p 8000:80 \
    registry.gitlab.developers.cam.ac.uk/uis/devops/raven/doc-samples/apache-oauth2
```

Visiting http://localhost:8000/ results in a protected website.

Optionally, you can set the passphrase used to encrypt session cookies:

```console
# Prefix these commands with " " to avoid them being recorded in the history.
$  export OIDC_CRYPTO_PASSPHRASE=some-strong-passphrase
```

Make sure to add `-e OIDC_CRYPTO_PASSPHRASE` to the docker command line options.
If `OIDC_CRYPTO_PASSPHRASE` is not set a new random value will be used each time
the container is run.

## Using an "env-file"

Instead of setting the `CLIENT_ID`, `CLIENT_SECRET` and `OIDC_CRYPTO_PASSPHRASE`
environment variables manually, you can create a file named `settings.env` and
load them when you run the container:

```console
$ docker run --rm -it --env-file settings.env -p 8000:80 \
    registry.gitlab.developers.cam.ac.uk/uis/devops/raven/doc-samples/apache-oauth2
```

There is an [example file](settings.env.example) in the repository which shows
the required format of the file.
