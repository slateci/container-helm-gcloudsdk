
# syntax=docker/dockerfile:1
FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:429.0.0

# Docker image build arguments:
ARG helmplugindiffversion=3.7.0
ARG helmpluginsecretsversion=4.4.2
ARG helmversion=3.11.3
ARG TARGETARCH
ARG varsversion=0.25.0

# Docker container environmental variables:
ENV GKE_CLUSTER_NAME=secundus
ENV HELM_SECRETS_BACKEND=vals

# Print debugging information:
RUN echo "I'm building for ${TARGETARCH}..."

# Install extra packages:
RUN apt-get install -y vim

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
