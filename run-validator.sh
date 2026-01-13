#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR"
VERSION="${2:-$(cat "$ROOT_DIR/.nimiq-version")}"
if [ -z "$VERSION" ]; then
  echo "Error: No version specified and .nimiq-version file not found or empty."
  exit 1
fi
CLIENT="$ROOT_DIR/bin/nimiq-client-$VERSION"

"$ROOT_DIR/scripts/ensure-nimiq-client.sh" "$VERSION"

if [ $# -lt 1 ]; then
  echo "Usage: $0 {1|2|3|4} [VERSION]"
  exit 1
fi

case "$1" in
  1) CONFIG="validator1.toml" ;;
  2) CONFIG="validator2.toml" ;;
  3) CONFIG="validator3.toml" ;;
  4) CONFIG="validator4.toml" ;;
  *) echo "Invalid validator id"; exit 1 ;;
esac

# Set devnet configuration override
export NIMIQ_OVERRIDE_DEVNET_CONFIG="$ROOT_DIR/dev-albatross.toml"

exec "$CLIENT" -c "$ROOT_DIR/$CONFIG"