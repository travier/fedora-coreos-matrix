.PHONY: all

include secrets

all:
	rm -rf ./config
	mkdir config
	cp template/* config/
	find config/ -type f -print0 | xargs -0 sed -i 's/%%DOMAIN_NAME%%/${DOMAIN_NAME}/; s/%%POSTGRES_PASSWORD%%/${POSTGRES_PASSWORD}/'
	sed 's/%%SSH_PUBKEY%%/${SSH_PUBKEY}/; s/%%POSTGRES_PASSWORD%%/${POSTGRES_PASSWORD}/' config.yaml | fcct --files-dir config --strict --output config.ign
