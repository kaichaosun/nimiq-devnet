#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="$ROOT_DIR/bin"
VERSION="$(cat "$ROOT_DIR/.nimiq-version")"

OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

case "$ARCH" in
  x86_64) ARCH="x86_64" ;;
  aarch64|arm64) ARCH="aarch64" ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

BINARY="nimiq-client"
TARGET="$BIN_DIR/$BINARY"

if [ -x "$TARGET" ]; then
  echo "✔ nimiq-client $VERSION already present"
  exit 0
fi

mkdir -p "$BIN_DIR"

URL="https://github.com/kaichaosun/nimiq-devnet/releases/download/$VERSION/${BINARY}-${OS}-${ARCH}"

echo "⬇ Downloading nimiq-client $VERSION..."
echo $URL
curl -L "$URL" -o "$TARGET"

chmod +x "$TARGET"

echo "✔ Installed $TARGET"
