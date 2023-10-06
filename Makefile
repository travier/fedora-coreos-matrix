.PHONY: all

include secrets

all:
	rm -rf ./config.tmp
	cp -a template config.tmp
	find config.tmp/ -type f -print0 | xargs -0 sed -i 's/%%DOMAIN_NAME%%/${DOMAIN_NAME}/g'
	find config.tmp/ -type f -print0 | xargs -0 sed -i 's/%%EMAIL%%/${EMAIL}/'
	find config.tmp/ -type f -print0 | xargs -0 sed -i 's/%%POSTGRES_PASSWORD%%/${POSTGRES_PASSWORD}/'
	find config.tmp/ -type f -print0 | xargs -0 sed -i 's/%%SYNAPSE_REGISTRATION_SHARED_SECRET%%/${SYNAPSE_REGISTRATION_SHARED_SECRET}/'
	find config.tmp/ -type f -print0 | xargs -0 sed -i 's/%%SYNAPSE_MACAROON_SECRET_KEY%%/${SYNAPSE_MACAROON_SECRET_KEY}/'
	find config.tmp/ -type f -print0 | xargs -0 sed -i 's/%%SYNAPSE_FORM_SECRET%%/${SYNAPSE_FORM_SECRET}/'
	find config.tmp/ -type f -print0 | xargs -0 sed -i 's/%%SYNAPSE_REGISTRATION%%/${SYNAPSE_REGISTRATION}/'
	echo ${SYNAPSE_SIGNING_KEY} > config.tmp/synapse/synapse.signing.key
	sed 's|%%SSH_PUBKEY%%|${SSH_PUBKEY}|' config.bu | butane --files-dir config.tmp --strict --output config.ign
