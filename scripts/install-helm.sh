#!/bin/bash

# Enable strict mode:
set -euo pipefail

# Script variables:
export VERSION="${1}"
export TARGET_ARCH="${2}"

echo "Downloading Helm version: ${VERSION}..."
curl -LO https://get.helm.sh/helm-v${VERSION}-linux-${TARGET_ARCH}.tar.gz
curl -LO https://get.helm.sh/helm-v${VERSION}-linux-${TARGET_ARCH}.tar.gz.sha256sum

echo "Verifying download..."
sha256sum -c helm-v${VERSION}-linux-${TARGET_ARCH}.tar.gz.sha256sum || exit 1

echo "Installing Helm..."
tar xzf helm-v${VERSION}-linux-${TARGET_ARCH}.tar.gz
mv linux-${TARGET_ARCH}/helm /usr/local/bin/helm

echo "Cleaning up..."
rm -rf \
  helm-v${VERSION}-linux-${TARGET_ARCH}.tar.gz \
  helm-v${VERSION}-linux-${TARGET_ARCH}.tar.gz.sha256sum \
  linux-${TARGET_ARCH}
