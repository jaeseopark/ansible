Ansible inventory and playbooks

## Usage

```bash
ssh-add
```

### Playbooks

```bash
# Setup mac hosts
ansible-playbook  mac.yml

# Orca Slicer disaster recovery (User presets)
ansible-playbook mac/orcaslicer/restore-presets.yml
```

```bash
# For all commands: clean restart docker compose with "-e clean_restart=true" (defaults to false)

ansible-playbook --ask-vault-password paperless.yml
ansible-playbook --ask-vault-password receep.yml
ansible-playbook --ask-vault-password bobbins.yml
ansible-playbook --ask-vault-password corganize.yml
ansible-playbook vps-nginx.yml # optionally: -e generate_certificates=true
ansible-playbook webcam.yml
ansible-playbook homer.yml

ansible-playbook vpn/wg.yml

ansible-playbook home-assistant/proxy.yml
ansible-playbook --ask-vault-pass home-assistant/rtl433.yml
ansible-playbook --ask-vault-pass misc/nas-clients.yml
ansible-playbook misc/dev.yml
ansible-playbook misc/pihole.yml
ansible-playbook misc/wiki.yml
ansible-playbook --ask-vault-pass misc/corganize.yml

ansible-playbook media/jellyfin.yml --ask-vault-pass
ansible-playbook media/arr.yml
ansible-playbook media/navidrome.yml
ansible-playbook media/filebrowser.yml
```

## Pihole

TODO: move when pihole becomes its own role

```bash
# Reset password
docker exec -it pihole pihole -a -p
```

### Change lookup rate limit

Rate-limiting can easily be disabled by setting `RATE_LIMIT=0/0` in `/etc/pihole/pihole-FTL.conf`. [Reference](https://pi-hole.net/2021/02/16/pi-hole-ftl-v5-7-and-web-v5-4-released/#page-content)



## Jellyfin

TODO: move when jellyfin becomes its own role

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
