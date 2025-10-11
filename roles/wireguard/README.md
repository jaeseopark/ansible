# Wireguard Role

This role sets up Wireguard VPN servers and clients.

## Usage

The role supports three modes:
- `server`: Initial server setup (installs packages, generates keys, configures firewall)
- `client`: Client setup (installs packages, generates keys, connects to server)
- `server_final`: Final server configuration (adds client peers to server config)

## Example Playbook

```yaml
---
- hosts: vps_hosts
  roles:
    - role: wireguard
      wireguard_mode: server

- hosts: wireguard_clients  
  roles:
    - role: wireguard
      wireguard_mode: client

- hosts: vps_hosts
  roles:
    - role: wireguard
      wireguard_mode: server_final
```

## Variables

All default variables are defined in `vars/main.yml`:

- `private_key_path`: Path to private key file (default: `/etc/wireguard/private.key`)
- `public_key_path`: Path to public key file (default: `/etc/wireguard/public.key`)
- `wg_conf_path`: Path to wireguard config file (default: `/etc/wireguard/wg0.conf`)
- `vps_public_key_path`: Path where server public key is stored on master
- `server_public_key_path`: Path where server public key is stored on clients
- `client_public_keys_path`: Directory for client public keys on server

Additional variables needed in inventory:
- `wg_server_ip`: Server IP in wireguard network
- `wg_ip`: Client IP in wireguard network (per client)

## Requirements

- `ansible.posix` collection (for sysctl module)
- Inventory groups: `vps_hosts` and `wireguard_clients`
