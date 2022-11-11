Ansible playbooks organized by use cases.

## Host machine

```bash
# Mac
pip3 install ansible

ssh-add # ansible uses SSH to communicate with the remote machines. Register the public key beforehand.
python3 -m ansible playbook -i inventory.ini vpn/nginx.yml
```
