# Fedora CoreOS Config to host a Matrix homeserver

Example Fedora CoreOS config to host a Matrix homeserver. This will setup:
  * nginx with let's encrypt for HTTPS support
  * synapse with postgresql and elements-web

For this setup, you need a domain name and two sub-domains:
  * example.tld
  * matrix.example.tld
  * chat.example.tld

## How to use

To generate the Ignition configs, you need `make` and `fcct`.

Then, you need to provide values for each variable in the secrets file:

```
$ cp secrets.example secrets
$ ${EDITOR} secrets
# Fill in all values
```

Then, you can generate the bootstrap Ignition config to create an instance that
will use Let's Encrypt to get certificates for your domain. You can skip this
step if yoiu already have certificates or prefer to get them differently. You
might also need to adapt this step to use another challenge method if you are
running in a cloud provider (see [DNS Plugins][plugins]).

```
$ make bootstrap
```

See the [Deploying](#Deploying) section for starting an instance with this
configuration.

Once this instance is successfully launched, you can retreive the certificates
using:

```
TODO
```

Finally, you can generate the final Ignition config with:

```
$ make
```

And start your Fedora CoreOS Matrix home server.

## Deploying

See the [Fedora CoreOS docs][deploy] for your platform.

[deploy]: https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/
[plugins]: https://certbot.eff.org/docs/using.html#dns-plugins
