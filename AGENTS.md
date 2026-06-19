This repository uses Ansible to automate:
* (Most common) **Docker Compose Deployments:** Deploying containerized apps to local network hosts.
* **Provisioning:** Initial machine setup.
* **VPS & Reverse Proxy:** Managing virtual private servers and proxying traffic to local hosts.
* **Automation:** Miscellaneous network and system administration tasks.

## Common Deployment Strategy

1. **Inventory:** Define hosts and port assignments.
2. **Roles:** Create host-agnostic, idempotent roles for application install/restart steps.
3. **Playbooks:** Map inventory to specific roles via root-level playbooks.
4. **Backups (Optional):** Attach the Restic role for data-sensitive applications.

### Dynamic host resolution
Some playbooks use the `dynamic_host_resolver` role to select the target host at runtime. That role requires `app_name` and looks up the host from the shared `apps` list, then adds it to the `resolved_host` group. Playbooks can safely target `resolved_host` instead of hard-coding the host name.

### Idempotency Flow
Application deployment tasks generally follow this lifecycle:
1. Install dependencies via built-in packages or community plugins.
2. Check if a service stop is required to update configurations (e.g., using `register: compose_file`).
3. Upload/update configuration and `docker-compose.yml` files.
4. Start or restart the service(s).

---

## Configuration & Secret Management

* **`defaults/main.yml`:** Plain-text constants, paths, ports, and feature flags.
* **`vars/main.yml`:** Sensitive data (e.g., credentials, passwords, API keys) encrypted via **Ansible Vault**.

> [!IMPORTANT]
> **Vault Handling:** If a role's `vars/main.yml` is encrypted, **do not modify it** while locked. If you need to read the full context or alter secret variables, stop and ask the user to decrypt the file first.

---

## Backup Strategy (Restic)

Standardized backup extension for application deployment. It appends a secondary Docker Compose file to the application to automate remote backups.

### Variables
*Required variables*
- `app_path`: Application directory where the app’s Docker Compose files live.
- `restic_repository_name`: Restic repository name used inside the S3 bucket.
- `restic_backup_paths`: A list of backup mounts. Each item must include `src`, and if more than one item is provided it must also include `target`.
- `restic_password`: Restic repository password (sensitive, usually stored in Vault-protected role vars).
- `restic_aws_access_key_id`: AWS access key ID for S3 storage.
- `restic_aws_secret_access_key`: AWS secret access key for S3 storage.
- `restic_s3_bucket`: S3 bucket name for the Restic repository, typically defined in inventory or host vars.

*Optional variables*
- `restic_keep_last`: Number of snapshots to keep; defaults to `7`.
- `restic_interval`: Seconds between backup runs; defaults to `86400` (1 day).
- `restart_restic`: Boolean to force the restic Docker Compose service to restart when the compose file exists; defaults to `false`.
- `restic_backup_paths[].target`: Mount target inside the restic container; defaults to `/backup` when only one path is provided.

### Considerations
* **Ideal for:** Applications with small, atomic file structures and minimal filesystem changes.
* **Not recommended for:** Monolithic single-file databases, as Restic cannot run efficient diffs on them, forcing full re-uploads every cycle.
