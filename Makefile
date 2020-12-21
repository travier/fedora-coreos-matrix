.PHONY: all

include secrets

all:
	rm -rf ./config
	mkdir config
	# sed -i template/ config/
	sed 's/%%SSH_PUBKEY%%/${SSH_PUBKEY}/; s/%%POSTGRES_PASSWORD%%/${POSTGRES_PASSWORD}/' config.yaml | fcct --files-dir config --strict --output config.ign
