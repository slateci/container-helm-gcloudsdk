
# NOTE: This file requires `docker buildx`. See the following resources for more details.
#
# * https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
#

# syntax=docker/dockerfile:1
FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:429.0.0

# Docker image build arguments:
ARG helmplugindiffversion=3.7.0
ARG helmpluginsecretsversion=4.4.2
ARG helmversion=3.11.3
ARG TARGETARCH=amd64
ARG varsversion=0.25.0

# Docker container environmental variables:
ENV GOOGLE_APPLICATION_CREDENTIALS=/work/gcloud-key.json
ENV GCLOUD_COMPUTE_ZONE=XXXX
ENV GCLOUD_GKE_CLUSTER=XXXX
ENV GCLOUD_PROJECT=XXXX
ENV HELM_SECRETS_BACKEND=vals

# Change working directory:
WORKDIR /tmp/scripts

# Set up scripts:
COPY ./scripts .

# Install Helm:
RUN chmod +x ./install-helm.sh && \
    ./install-helm.sh ${helmversion} ${TARGETARCH}

# Install Helm Plugins
RUN helm plugin install https://github.com/databus23/helm-diff --version ${helmplugindiffversion} && \
    helm plugin install https://github.com/jkroepke/helm-secrets --version ${helmpluginsecretsversion}

# Install helmfile/vals
RUN chmod +x ./install-vals.sh && \
    ./install-vals.sh ${varsversion} ${TARGETARCH}

# Clean up scripts:
RUN rm -rf /tmp/scripts

# Change working directory:
WORKDIR /

# Prepare entrypoint:
COPY ./scripts/docker-entrypoint.sh ./
RUN chmod +x ./docker-entrypoint.sh

# Change working directory:
WORKDIR /work

# Volumes:
VOLUME /work

# Run once the container has started:
ENTRYPOINT [ "/docker-entrypoint.sh" ]
