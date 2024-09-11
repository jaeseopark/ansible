Ansible inventory and playbooks

## Terminologies

- Master: The node from which the Ansible playbooks are executed
- Remote: Ansible SSH target nodes
- WG/VPN Server: public-facing WG node (VPS)
- WG/VPN Clients: local WG nodes

## Usage

```bash
ssh-add
```

### Mac

See [mac/README.md](mac/README.md) for more info.

```bash
# Setup mac hosts
ansible-playbook -i inventory.ini mac/main.yml

# Orca Slicer disaster recovery
ansible-playbook -i inventory.ini mac/orcaslicer-restore-presets.yml
```

```bash
ansible-playbook -i inventory.ini vpn/wg.yml
ansible-playbook -i inventory.ini vpn/nginx-cert.yml # Use only when necessary. See API rate limit: https://letsencrypt.org/docs/duplicate-certificate-limit/
ansible-playbook -i inventory.ini vpn/nginx.yml

ansible-playbook -i inventory.ini dashboards/homer.yml
ansible-playbook -i inventory.ini home-assistant/homeassistant.yml
ansible-playbook -i inventory.ini --ask-vault-pass misc/nas-clients.yml
ansible-playbook -i inventory.ini misc/dev.yml
ansible-playbook -i inventory.ini misc/paperless.yml
ansible-playbook -i inventory.ini misc/pihole.yml
ansible-playbook -i inventory.ini misc/wiki.yml
ansible-playbook -i inventory.ini misc/corganize.yml
ansible-playbook -i inventory.ini --ask-vault-pass misc/corganize-daemon.yml

ansible-playbook -i inventory.ini media/jellyfin.yml
ansible-playbook -i inventory.ini media/arr.yml
ansible-playbook -i inventory.ini media/navidrome.yml
```

### Debugging Ansible variables

```bash
ansible-inventory -i inventory.ini -y --list > inventory.yaml
```
