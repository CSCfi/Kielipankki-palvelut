#!/bin/sh

set -e

for i in $(seq 12); do
  while read -r url; do
    curl "$url" > /dev/null &
  done < "$1"
  wait
done
