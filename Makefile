.PHONY: all

include secrets

all:
	rm -rf ./config
	cp -a template config
	find config/ -type f -print0 | xargs -0 sed -i 's/%%DOMAIN_NAME%%/${DOMAIN_NAME}/'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%EMAIL%%/${EMAIL}/'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%POSTGRES_PASSWORD%%/${POSTGRES_PASSWORD}/'
	sed 's/%%SSH_PUBKEY%%/${SSH_PUBKEY}/; s/%%POSTGRES_PASSWORD%%/${POSTGRES_PASSWORD}/' config.yaml \
		| fcct --files-dir config --strict --output config.ign

bootstrap:
	rm -rf ./config-bootstrap
	cp -a template-bootstrap config-bootstrap
	find config-bootstrap -type f -print0 | xargs -0 sed -i 's/%%DOMAIN_NAME%%/${DOMAIN_NAME}/'
	find config-bootstrap -type f -print0 | xargs -0 sed -i 's/%%EMAIL%%/${EMAIL}/'
	sed 's/%%SSH_PUBKEY%%/${SSH_PUBKEY}/' bootstrap.yaml \
		| fcct --files-dir config-bootstrap --strict --output bootstrap.ign
