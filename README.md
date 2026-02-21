# ocdc: Opencode Dev Container

Lightweight Docker setup for developing with Opencode inside an Arch-based container.

## Requirements
- Docker
- docker compose plugin (or `docker-compose`)

## Usage
- Build and start: `docker compose up -d`
- Attach a shell: `docker exec -it opencode-dev bash`
- Project sources are mounted from `${HOME}/.local/src` into `/home/dev/.local/src` in the container.
