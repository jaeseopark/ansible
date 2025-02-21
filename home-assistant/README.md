## Proxy

The managed installation of Home Assistant on the Raspberry Pi does not allow Ansible to interact with its underlying OS. This breaks the existing Ansible playbooks for WireGuard and the Nginx reverse proxy. As a workaround, I am adding an additional Nginx proxy layer, which isn't ideal but is still better than other installation methods.
