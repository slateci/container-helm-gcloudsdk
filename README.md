
# Helm GCloud SDK Utility Image

[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-blue.svg)](http://unlicense.org/)
[![Release](https://github.com/slateci/container-helm-gcloudsdk/actions/workflows/release.yml/badge.svg)](https://github.com/slateci/container-helm-gcloudsdk/actions/workflows/release.yml)

An `amd64`/`arm64` utility container image for Helm and the Google Cloud SDK.

## Quick Try

### Prepare Environment

1. Install [Podman](https://podman.io/getting-started/installation) or [Docker](https://docs.docker.com/get-docker/).
    * In the commands below, `podman` may be interchanged with `docker` depending on your choice.
1. Create a new `.env` from `./.env.tmpl` in this repository and place it somewhere on the host (e.g. `/path/to/.env`).
1. Replace the placeholder content with actual values.
1. Download a JSON key for the Google `<service-account` and place it at the base of the desired mount point for the image (e.g. `/path/to/mount/gcloud-key.json`).

### Example Commands

Run the image and mount the present working directory 

```shell
[your@localmachine helm-slate-api]$ podman run -it -v ${PWD}:/work:Z --env-file /path/to/.env ghcr.io/slateci/container-helm-gcloudsdk:latest
===================================================
Helm/GCloud Utility Container
===================================================
Activated service account credentials for: <service-account>

To take a quick anonymous survey, run:
  $ gcloud survey

Updated property [core/project].
WARNING: Property validation for compute/zone was skipped.
Updated property [compute/zone].
Fetching cluster endpoint and auth data.
kubeconfig entry generated for <gke-cluster>.
```

Get the pods in the `development` Helm namespace.

```shell
[root@454344d8c4ca work]# kubectl get pods --namespace development
W1010 18:37:49.154648     133 gcp.go:119] WARNING: the gcp auth plugin is deprecated in v1.22+, unavailable in v1.26+; use gcloud instead.
To learn more, consult https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
NAME                                           READY   STATUS    RESTARTS   AGE
slate-api-dev-deployment-5d87f5ddf4-wc2pg      1/1     Running   0          2d23h
slate-portal-dev-deployment-6d7874944d-8gl8c   1/1     Running   0          2d21h
...
...
```

## How to Contribute

1. Submit a pull request against `master`.
2. Once the automated status checks pass, complete the pull request by squash-merging with `master`.
3. Apply a [semantic version](https://semver.org/) tag to the resulting commit (e.g. `v1.0.1`).
4. At this point the automatic image build on GitHub will trigger, tagging the new image with the semantic version and `latest`.

## Image Includes

* [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
* [Helm](https://helm.sh/)
    * [databus23/helm-diff](https://github.com/databus23/helm-diff)
    * [jkroepke/helm-secrets](https://github.com/jkroepke/helm-secrets)
* [helmfile/vals](https://github.com/helmfile/vals)

## Examples

See [Helm Commands](https://docs.google.com/document/d/1Tn31mUMoJpKJrSvxemOAgS39NkJLQPk_AN5YwUfk4gM/edit#).
