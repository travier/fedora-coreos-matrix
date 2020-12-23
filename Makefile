.PHONY: all certs

include secrets

all:
	rm -rf ./config
	cp -a template config
	find config/ -type f -print0 | xargs -0 sed -i 's/%%DOMAIN_NAME%%/${DOMAIN_NAME}/g'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%EMAIL%%/${EMAIL}/'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%POSTGRES_PASSWORD%%/${POSTGRES_PASSWORD}/'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%SYNAPSE_REGISTRATION_SHARED_SECRET%%/${SYNAPSE_REGISTRATION_SHARED_SECRET}/'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%SYNAPSE_MACAROON_SECRET_KEY%%/${SYNAPSE_MACAROON_SECRET_KEY}/'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%SYNAPSE_FORM_SECRET%%/${SYNAPSE_FORM_SECRET}/'
	echo ${SYNAPSE_SIGNING_KEY} > config/synapse/synapse.signing.key
	sed 's/%%SSH_PUBKEY%%/${SSH_PUBKEY}/; s/%%POSTGRES_PASSWORD%%/${POSTGRES_PASSWORD}/' config.yaml \
		| fcct --files-dir config --strict --output config.ign

certs:
	rm -rf ./config
	cp -a template config
	cp certs.tar.gz config
	find config/ -type f -print0 | xargs -0 sed -i 's/%%DOMAIN_NAME%%/${DOMAIN_NAME}/g'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%EMAIL%%/${EMAIL}/'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%POSTGRES_PASSWORD%%/${POSTGRES_PASSWORD}/'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%SYNAPSE_REGISTRATION_SHARED_SECRET%%/${SYNAPSE_REGISTRATION_SHARED_SECRET}/'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%SYNAPSE_MACAROON_SECRET_KEY%%/${SYNAPSE_MACAROON_SECRET_KEY}/'
	find config/ -type f -print0 | xargs -0 sed -i 's/%%SYNAPSE_FORM_SECRET%%/${SYNAPSE_FORM_SECRET}/'
	echo ${SYNAPSE_SIGNING_KEY} > config/synapse/synapse.signing.key
	sed 's/%%SSH_PUBKEY%%/${SSH_PUBKEY}/; s/%%POSTGRES_PASSWORD%%/${POSTGRES_PASSWORD}/' config-certs.yaml \
		| fcct --files-dir config --strict --output config-certs.ign
