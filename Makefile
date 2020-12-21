.PHONY: all

include secrets

all:
	rm -rf ./config
	mkdir config
	# sed -i template/ config/
	sed 's/%%SSH_PUBKEY%%/${SSH_PUBKEY}/' config.yaml | fcct --files-dir config --strict --output config.ign
