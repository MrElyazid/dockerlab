# dockerlab :

A small self-hosted stack running on a laptop via a single Cloudflare Tunnel.

On a new machine, some folders are needed:

```bash
mkdir -p ~/books ~/music ~/jellyfin
```

## Conventions

- One folder per app: `docker-compose.yml` + `.env` (where secrets are needed) + `data/`.
- Host ports bind to `127.0.0.1`; access is tunnel-only.
- Images are pinned to a version. to update : `./stack.sh pull` then `./stack.sh up`.

## Managing the stack

```bash
./stack.sh up        # start everything
./stack.sh ps        # status
./stack.sh pull      # pull pinned images
./stack.sh up        # recreate anything that changed
./stack.sh restart kavita
./stack.sh down
```

