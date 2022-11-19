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
ssh-add

ansible-playbook -i inventory.ini vpn/wg.yml
ansible-playbook -i inventory.ini vpn/nginx.yml
```

## Terminologies

Master: The node from which the Ansible playbook is executed
Remote: Ansible SSH target node(s)
WG/VPN Server: WG node whose IP is exposed to the public
WG/VPN Clients: WG nodes that connect to the server
