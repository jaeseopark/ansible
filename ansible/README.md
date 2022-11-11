Ansible inventory and playbooks

## Usage

```bash
# Mac
pip3 install ansible
ssh-add

python3 -m ansible playbook -i inventory.ini vpn/wg.yml
python3 -m ansible playbook -i inventory.ini vpn/nginx.yml
```

## Terminologies

Master: The node from which the Ansible playbook is executed
Remote: Ansible SSH target node(s)
WG/VPN Server: WG node whose IP is exposed to the public
WG/VPN Clients: WG nodes that connect to the server
