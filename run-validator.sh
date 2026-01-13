#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR"
CLIENT="$ROOT_DIR/bin/nimiq-client"

"$ROOT_DIR/scripts/ensure-nimiq-client.sh"

if [ $# -ne 1 ]; then
  echo "Usage: $0 {1|2|3|4}"
  exit 1
fi

case "$1" in
  1) CONFIG="validator1.toml" ;;
  2) CONFIG="validator2.toml" ;;
  3) CONFIG="validator3.toml" ;;
  4) CONFIG="validator4.toml" ;;
  *) echo "Invalid validator id"; exit 1 ;;
esac

exec "$CLIENT" -c "$ROOT_DIR/$CONFIG"
