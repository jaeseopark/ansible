Ansible inventory and playbooks

## Terminologies

- Master: The node from which the Ansible playbooks are executed
- Remote: Ansible SSH target nodes
- WG/VPN Server: WG node whose IP is exposed to the public
- WG/VPN Clients: WG nodes that connect to the server

## Usage

### One Time Setup
```bash
# Mac (bash)
pip3 install ansible

# Show where Ansible is installed
pip3 show ansible | grep Location
# Location: /Users/jaeseopark/Library/Python/3.9/lib/python/site-packages

# Add the bin directory to PATH in ~/.bash_profile
# export PATH=$PATH:/Users/jaeseopark/Library/Python/3.9/bin

ansible-galaxy collection install ansible.posix # Needed for the nas playbook
```

## Configuring the master node

- Enable SSH in the Sharing settings
- `cat id_rsa.pub >> authorized_keys`
- use `--ask-become-pass`

### Run a Playbook

```bash
ssh-add

ansible-playbook -i inventory.ini dashboards/homer.yml
ansible-playbook -i inventory.ini home-assistant/homeassistant.yml
ansible-playbook -i inventory.ini --ask-become-pass master/update-hostnames.yml

ansible-playbook -i inventory.ini vpn/wg.yml
ansible-playbook -i inventory.ini vpn/nginx-cert.yml # Use only when necessary. See API rate limit: https://letsencrypt.org/docs/duplicate-certificate-limit/
ansible-playbook -i inventory.ini vpn/nginx.yml

ansible-playbook -i inventory.ini --ask-vault-pass misc/nas-clients.yml
ansible-playbook -i inventory.ini misc/dev.yml

ansible-playbook -i inventory.ini media/jellyfin.yml
ansible-playbook -i inventory.ini media/arr.yml
ansible-playbook -i inventory.ini media/navidrome.yml

ansible-playbook -i inventory.ini misc/paperless.yml
ansible-playbook -i inventory.ini misc/pihole.yml
ansible-playbook -i inventory.ini misc/wiki.yml
ansible-playbook -i inventory.ini misc/corganize.yml
```

## Debugging Ansible variables

```bash
ansible-inventory -i inventory.ini -y --list > inventory.yaml
```
