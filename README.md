# Fedora CoreOS Config to host a Matrix homeserver

Example Fedora CoreOS config to host a Matrix homeserver. This will setup:
  * nginx with let's encrypt for HTTPS support
  * synapse with postgresql and elements-web

For this setup, you need a domain name and two sub-domains:
  * example.tld
  * matrix.example.tld
  * chat.example.tld

## How to use

To generate the final Ignition file, you need `make` and `fcct`..

```
$ cp secrets.example secrets
$ ${EDITOR} secrets
# Fill in all values
$ make
```

## Deploying

See the [Fedora CoreOS docs][deploy] for your platform.

[deploy]: https://docs.fedoraproject.org/en-US/fedora-coreos/getting-started/
