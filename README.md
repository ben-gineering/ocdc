# ocdc: Opencode Dev Container

Lightweight Docker setup for developing with Opencode inside an Arch-based container.

## Requirements
- Docker
- docker compose plugin (or `docker-compose`)
- SSH agent (for git operations inside container)

## SSH Agent Setup

The docker-compose.yml mounts the host's SSH agent socket into the container. This requires SSH_AUTH_SOCK to be set.

### Temporary Setup

Run the build command with ssh-agent in the same shell:

```bash
eval "$(ssh-agent -s)" && docker compose build
```

### Persistent Setup

Enable the ssh-agent systemd user service to auto-start on login:

```bash
systemctl --user enable --now ssh-agent
```

Verify it's running:

```bash
systemctl --user status ssh-agent
```

## Usage
- Build and start: `docker compose up -d`
- Attach a shell: `docker exec -it opencode-dev bash`
- Project sources are mounted from `${HOME}/.local/src` into `/home/dev/.local/src` in the container.
