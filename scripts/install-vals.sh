#!/bin/bash

# Enable strict mode:
set -euo pipefail

# Script variables:
export VERSION="${1}"
export TARGET_ARCH="${2}"

echo "Downloading vals version: ${VERSION}..."
curl -LO https://github.com/helmfile/vals/releases/download/v${VERSION}/vals_${VERSION}_linux_${TARGET_ARCH}.tar.gz
curl -LO https://github.com/helmfile/vals/releases/download/v${VERSION}/vals_${VERSION}_checksums.txt

echo "Verifying download..."
echo $(cat vals_${VERSION}_checksums.txt | grep .*vals_${VERSION}_linux_${TARGET_ARCH}.tar.gz) > checksum.txt
sha256sum -c checksum.txt || exit 1

echo "Installing vals..."
tar xzf vals_${VERSION}_linux_${TARGET_ARCH}.tar.gz
mv vals /usr/local/bin

echo "Cleaning up..."
rm -rf \
  vals_${VERSION}_linux_${TARGET_ARCH}.tar.gz \
  vals_${VERSION}_checksums.txt \
  checksum.txt
