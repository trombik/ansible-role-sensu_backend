# `trombiksensu_backend`

`ansible` role to install `sensu-go-backend`.

# Requirements

None

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `sensu_backend_package` | Package name of `sensu-go-backend` | `{{ __sensu_backend_package }}` |
| `sensu_backend_extra_packages` | A list of extra packages to install | `[]` |
| `sensu_backend_user` | User name of `sensu-go-backend` | `{{ __sensu_backend_user }}` |
| `sensu_backend_group` | Group name of `sensu-go-backend` | `{{ __sensu_backend_group }}` |
| `sensu_backend_log_dir` | Path to log directory | `/var/log/sensu` |
| `sensu_backend_db_dir` | Path to database directory | `{{ __sensu_backend_db_dir }}` |
| `sensu_backend_cache_dir` | Path to cache directory | `{{ __sensu_backend_cache_dir }}` |
| `sensu_backend_service` | Service name of `sensu-go-backend` | `{{ __sensu_backend_service }}` |
| `sensu_backend_conf_dir` | Path to configuration directory | `{{ __sensu_backend_conf_dir }}` |
| `sensu_backend_conf_file` | Path to `backend.yml` | `{{ sensu_backend_conf_dir }}/backend.yml` |
| `sensu_backend_config` | Content of `backend.yml` | `""` |
| `sensu_backend_flags` | Additional flags to pass the service | `""` |


## Debian

| Variable | Default |
|----------|---------|
| `__sensu_backend_package` | `sensu-go-backend` |
| `__sensu_backend_user` | `sensu` |
| `__sensu_backend_group` | `sensu` |
| `__sensu_backend_db_dir` | `/var/lib/sensu` |
| `__sensu_backend_cache_dir` | `/var/cache/sensu/sensu-backend` |
| `__sensu_backend_service` | `sensu-backend` |
| `__sensu_backend_conf_dir` | `/etc/sensu` |

# Dependencies

None

# Example Playbook

```yaml
---
- hosts: localhost
  roles:
    - name: trombik.apt_repo
      when: ansible_os_family == 'Debian'
    - name: trombik.sensu_agent
    - ansible-role-sensu_backend
  vars:
    apt_repo_keys_to_add:
      - https://packagecloud.io/sensu/stable/gpgkey
    apt_repo_to_add:
      - deb https://packagecloud.io/sensu/stable/ubuntu/ bionic main
    apt_repo_enable_apt_transport_https: yes
    sensu_backend_extra_packages:
      - sensu-go-cli
    sensu_backend_config:
      state-dir: "{{ sensu_backend_db_dir }}"
      cache-dir: "{{ sensu_backend_cache_dir }}"
      log-level: info
    sensu_agent_config:
      name: localhost
      namespace: default
      backend-url: ws://localhost:8081
      log-level: debug
```

# License

```
Copyright (c) 2019 Tomoyuki Sakurai <y@trombik.org>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <y@trombik.org>

This README was created by [qansible](https://github.com/trombik/qansible)
