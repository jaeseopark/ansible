Ansible inventory and playbooks

## Usage

```bash
# Mac (bash)
pip3 install ansible

# Show where Ansible is installed
pip3 show ansible | grep Location
# Location: /Users/jaeseopark/Library/Python/3.9/lib/python/site-packages

# Add the bin directory to PATH in ~/.bash_profile
# export PATH=$PATH:/Users/jaeseopark/Library/Python/3.9/bin
```

```bash
ansible-galaxy collection install ansible.posix # Needed for the nas playbook
```

```bash
ssh-add

ansible-playbook -i inventory.ini vpn/wg.yml
ansible-playbook -i inventory.ini vpn/nginx-cert.yml # Use only when necessary. See API rate limit: https://letsencrypt.org/docs/duplicate-certificate-limit/
ansible-playbook -i inventory.ini vpn/nginx.yml
ansible-playbook -i inventory.ini misc/nas-clients.yml
ansible-playbook -i inventory.ini misc/dev.yml
```

## Terminologies

- Master: The node from which the Ansible playbook is executed
- Remote: Ansible SSH target node(s)
- WG/VPN Server: WG node whose IP is exposed to the public
- WG/VPN Clients: WG nodes that connect to the server

## Configuring the main mac

- Enable SSH in the Sharing settings
- `cat id_rsa.pub >> authorized_keys`
- use `--ask-become-pass`

## Debugging Ansible variables

```bash
ansible-inventory -i inventory.ini -y --list > inventory.yaml
```
