#!/usr/bin/env bash
#
#   ./stack.sh up                 start all apps (detached)
#   ./stack.sh down               stop all apps
#   ./stack.sh pull               pull pinned images
#   ./stack.sh ps                 status of all apps
#   ./stack.sh restart            restart all apps
#   ./stack.sh config             validate all compose files
#   ./stack.sh <command> kavita   run for specific apps only
#
set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APPS=(ampache cloudflared hedgedoc jellyfin kavita site stirling-pdf)

usage() {
    echo "usage: $0 <up|down|pull|ps|restart|config> [app ...]"
    echo "apps:  ${APPS[*]}"
    exit 1
}

cmd="${1:-}"
shift || true
[ -z "$cmd" ] && usage

case "$cmd" in
    up)      action="up -d" ;;
    down)    action="down" ;;
    pull)    action="pull" ;;
    ps)      action="ps" ;;
    restart) action="restart" ;;
    config)  action="config" ;;
    *)       usage ;;
esac

if [ "$#" -gt 0 ]; then
    targets=("$@")
else
    targets=("${APPS[@]}")
fi

rc=0
for app in "${targets[@]}"; do
    dir="$ROOT/$app"
    if [ ! -f "$dir/docker-compose.yml" ]; then
        echo "== $app: no docker-compose.yml, skipping"
        continue
    fi
    echo "== $app"
    (cd "$dir" && docker compose $action) || rc=1
done
exit $rc
