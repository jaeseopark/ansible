Ansible inventory and playbooks

## Usage

```bash
ssh-add
```

### Playbooks

```bash
# Setup mac hosts
ansible-playbook mac.yml

# Orca Slicer disaster recovery (User presets)
ansible-playbook mac/orcaslicer/restore-presets.yml
```

```bash
# For playbooks that use the restic role: -e restart_restic=true to restart restic.

ansible-playbook --ask-vault-password paperless.yml
ansible-playbook --ask-vault-password receep.yml
ansible-playbook --ask-vault-password bobbins.yml
ansible-playbook --ask-vault-password corganize.yml -e dev=true
ansible-playbook --ask-vault-password corganize-server.yml
ansible-playbook --ask-vault-password corganize-consumer.yml
ansible-playbook --ask-vault-pass transmission.yml
ansible-playbook vps-nginx.yml -v -e generate_certificates=true
ansible-playbook jellyfin.yml
ansible-playbook webcam.yml
ansible-playbook homer.yml
ansible-playbook wireguard.yml # TODO: test
ansible-playbook --ask-vault-pass rtl433.yml

ansible-playbook home-assistant/proxy.yml
ansible-playbook --ask-vault-pass --ask-become-pass misc/nas-clients.yml
ansible-playbook misc/dev.yml
ansible-playbook misc/pihole.yml
ansible-playbook misc/wiki.yml

ansible-playbook media/arr.yml
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
