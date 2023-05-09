#!/bin/bash

# Enable strict mode:
set -euo pipefail

# Set gcloud cli auth and configuration:
gcloud auth login
gcloud init
gcloud container clusters get-credentials $GKE_CLUSTER_NAME

/bin/bash