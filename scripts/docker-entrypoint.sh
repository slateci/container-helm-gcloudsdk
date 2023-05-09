#!/bin/bash

# Enable strict mode:
set -euo pipefail

# Set gcloud cli auth and configuration:
gcloud init
gcloud auth application-default login
gcloud container clusters get-credentials $GKE_CLUSTER_NAME

/bin/bash