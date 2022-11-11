Ansible playbooks organized by use cases.

## Host machine

```bash
# Mac
pip3 install ansible
ssh-add

# Provision WG host
python3 -m ansible playbook -i inventory.ini vpn/wg-server.yml

# Provision WG client
python3 -m ansible playbook -i inventory.ini vpn/wg-client.yml --hosts=...

# Provision Nginx on VPN host
python3 -m ansible playbook -i inventory.ini vpn/nginx.yml --clients=... keys=...
```
