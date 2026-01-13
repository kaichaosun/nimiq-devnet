#!/usr/bin/env bash

set -e

if [ $# -ne 1 ]; then
  echo "Usage: $0 {1|2|3|4}"
  exit 1
fi

case "$1" in
  1)
    CONFIG="./client1.toml"
    ;;
  2)
    CONFIG="./client2.toml"
    ;;
  3)
    CONFIG="./client3.toml"
    ;;
  4)
    CONFIG="./client4.toml"
    ;;
  *)
    echo "Invalid argument: $1"
    echo "Usage: $0 {1|2|3|4}"
    exit 1
    ;;
esac

exec ./nimiq-client -c "$CONFIG"
