#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="$ROOT_DIR/bin"
VERSION="${1:-$(cat "$ROOT_DIR/.nimiq-version")}"
if [ -z "$VERSION" ]; then
  echo "Error: No version specified and .nimiq-version file not found or empty."
  exit 1
fi

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

# --- lock setup ---
mkdir -p $BIN_DIR
LOCKDIR="bin/nimiq-client.lock"

# try to acquire lock (atomic)
while ! mkdir "${LOCKDIR}" 2>/dev/null; do
  echo "Another process is downloading, waiting..."
  sleep 3
done

# cleanup on exit
cleanup() { rm -rf "${LOCKDIR}"; }
trap cleanup EXIT


BINARY="nimiq-client"
TARGET="$BIN_DIR/$BINARY-$VERSION"

if [ -x "$TARGET" ]; then
  echo "✔ nimiq-client $VERSION already present"
  exit 0
fi

URL="https://github.com/kaichaosun/nimiq-devnet/releases/download/$VERSION/${BINARY}-${OS}-${ARCH}"

echo "⬇ Downloading nimiq-client $VERSION..."
echo $URL
curl -L "$URL" -o "$TARGET"

chmod +x "$TARGET"

echo "✔ Installed $TARGET"