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

### Playbooks

```bash
# Setup mac hosts
ansible-playbook -i inventory.ini mac/main.yml
echo 'export ANSIBLE_INVENTORY=inventory.ini' >> ~/.bash_profile
echo 'export ANSIBLE_INVENTORY=inventory.ini' >> ~/.zshrc

# Orca Slicer disaster recovery (User presets)
ansible-playbook mac/orcaslicer/restore-presets.yml
```

```bash
# For all commands: clean restart docker compose with "-e clean_restart=true" (defaults to false)

ansible-playbook --ask-vault-password databases.yml
ansible-playbook --ask-vault-password bobbins.yml
ansible-playbook hardware.yml
ansible-playbook homelab.yml

ansible-playbook vpn/wg.yml
# Use only when necessary. See API rate limit: https://letsencrypt.org/docs/duplicate-certificate-limit/
ansible-playbook vpn/nginx-cert.yml
ansible-playbook vpn/nginx.yml

ansible-playbook home-assistant/proxy.yml
ansible-playbook --ask-vault-pass home-assistant/rtl433.yml
ansible-playbook --ask-vault-pass misc/nas-clients.yml
ansible-playbook misc/dev.yml
ansible-playbook misc/pihole.yml
ansible-playbook misc/wiki.yml
ansible-playbook --ask-vault-pass misc/corganize.yml
ansible-playbook misc/corganize-server.yml

ansible-playbook media/jellyfin.yml --ask-vault-pass
ansible-playbook media/arr.yml
ansible-playbook media/navidrome.yml
ansible-playbook media/filebrowser.yml
```

### Debugging Ansible variables

```bash
ansible-inventory -i inventory.ini -y --list > inventory.yaml
```

## Pihole

```bash
# Reset password
docker exec -it pihole pihole -a -p
```

### Change lookup rate limit

Rate-limiting can easily be disabled by setting `RATE_LIMIT=0/0` in `/etc/pihole/pihole-FTL.conf`. [Reference](https://pi-hole.net/2021/02/16/pi-hole-ftl-v5-7-and-web-v5-4-released/#page-content)

## Jellyfin

### Connect to a new host

1. Put the new config in `./media/jellyfin.wg.conf`. The file should look like:
    ```conf
    [Interface]
    # Device: ...
    PrivateKey = ...
    Address = ...
    DNS = ...

    [Peer]
    PublicKey = ...
    AllowedIPs = ...
    Endpoint = ...
    ```
1. Encrypt the conf file with Ansible Vault:
    ```shell
    # This encrypts the file in-place
    ansible-vault encrypt ./media/jellyfin.wg.conf
    ```
1. Run the jellyfin playbook as usual.
