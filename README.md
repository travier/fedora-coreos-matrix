# Fedora CoreOS Config to host a Matrix homeserver

Example Fedora CoreOS config to host a Matrix homeserver. This will setup:
  * nginx with let's encrypt for HTTPS support
  * synapse with postgresql and elements-web

For this setup, you need a domain name and two sub-domains:
  * example.tld
  * matrix.example.tld
  * chat.example.tld

For Let's Encrypt support, those domains must be configured beforehand to
resolve to the IP address that will be assigned to your server. If you do not
know what IP address will be assigned to you server in advance (common case in
some cloud providers), you might want to use another ACME challenge method to
get Let's Encrypt certificates (see [DNS Plugins][plugins]).

## How to use

To generate the Ignition configs, you need `make` and `fcct`.

Then, you need to provide values for each variable in the secrets file:

```
$ cp secrets.example secrets
$ ${EDITOR} secrets
# Fill in all values
```

### Configuring Synapse

The synapse configuration requires to setup a few secrets, you can generate these secret using
the following command :

```
$ podman run -it --rm -v $PWD:/data:z -e SYNAPSE_SERVER_NAME=my.matrix.host -e SYNAPSE_REPORT_STATS=yes matrixdotorg/synapse:latest generate
```
Replace my.matrix.host by your domain name (same as the value define in the secrets file).

This command will generate 3 files

- homeserver.yaml
- my.matrix.host.log.config
- my.matrix.host.signing.key

#### Configuration

A template version of the generated homeserver.yaml is present under `template/synapse/homeserver.yaml`.

First we want to replace the secrets with values that were generated for you by
synapse.

In the secrets file, edit the following variables

SYNAPSE_REGISTRATION_SHARED_SECRET, with the content of `registration_shared_secret` in homeserver.yaml
SYNAPSE_MACAROON_SECRET_KEY, with the content of `macaroon_secret_key` in homeserver.yaml
SYNAPSE_FORM_SECRET, with the content of `form_secret` in homeserver.yaml

You secrets file should look like:

```
SSH_PUBKEY="ssh-rsa AAAA..."
POSTGRES_PASSWORD=a_passpharse_for_my_database
DOMAIN_NAME=my.matrix.domain
EMAIL=root@example.com
SYNAPSE_REGISTRATION_SHARED_SECRET=a_very_long_string_generated_by_synapse
SYNAPSE_MACAROON_SECRET_KEY=a_very_long_string_generated_by_synapse
SYNAPSE_FORM_SECRET=a_very_long_string_generated_by_synapse
```

If you wish to change other synapse settings you can edit directly `template/synapse/homeserver.yaml`

#### Signing key

Move `my.matrix.host.signing.key` under `template/synapse/synapse.signing.key`

```
$ mv my.matrix.host.signing.key template/synapse/synapse.signing.key
```

#### Logging

If you want to change the logging configuration, you can edit directly `template/synapse/synapse.log.config`

## Generate the ignition configuration

Finally, you can generate the final Ignition config with:

```
$ make
```

You are now ready to deploy your Fedora CoreOS Matrix home server.

## Deploying

See the [Fedora CoreOS docs][deploy] for instructions on how to use this
Ignition config to deploy a Fedora CoreOS instance on your prefered platform.

[deploy]: https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/
[plugins]: https://certbot.eff.org/docs/using.html#dns-plugins
