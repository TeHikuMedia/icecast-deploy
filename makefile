
ANSIBLE_VAULT_PASSWORD ?= $(shell op read "op://Developers/Te Hiku Ansible Vault Password/password")

# Servers for our production streaming
# These are internal as we use liquidsoap with redundant icecast links to stream to this.
production-streamers:
	@ANSIBLE_VAULT_PASSWORD=$(ANSIBLE_VAULT_PASSWORD) ansible-playbook -i inventory/aws_ec2.yml --vault-id vault.sh --private-key=~/.ssh/libretime.pem production_streamer.yml

provision:
	@ANSIBLE_VAULT_PASSWORD=$(ANSIBLE_VAULT_PASSWORD) ansible-playbook -i inventory/aws_ec2.yml --vault-id vault.sh --private-key=~/.ssh/libretime.pem production_streamer.yml -t provision