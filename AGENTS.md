AGENTS.md

Use `defaults/main.yml` for role-specific plain-text constants and defaults.
Use `vars/main.yml` for secrets that must be encrypted with Ansible Vault.

If a role's `vars/main.yml` is encrypted, do not modify it until the file is decrypted.
If you need to change secret variables or read the full content of the file for broader context, stop and ask the user to decrypt the file first.

Example:
- `defaults/main.yml`: paths, ports, feature flags
- `vars/main.yml`: camera credentials, RTSP passwords, YouTube keys

