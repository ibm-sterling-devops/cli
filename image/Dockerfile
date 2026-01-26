FROM registry.access.redhat.com/ubi9/python-312
ARG VERSION_LABEL
ARG ARCHITECTURE

LABEL maintainer="Sterling DevOps Team" \
      description="Custom image for Sterling deployments with oc, kubectl, helm, git, and ansible" \
      version="1.0"

# Set environment variables
ENV ANSIBLE_VERSION=2.15 \
    HELM_VERSION=3.16.3 \
    IBMPAK_VERSION=1.20.0 \
    IBMCLI_VERSION=2.38.1 \
    OC_VERSION=4.14 \
    HOME=/app-root

# 1. Create sterling user and set up home directory
USER root
RUN useradd -u 1010 -r -g 0 -d /app-root -s /bin/bash \
    -c "Sterling user" sterling && \
    mkdir -p /app-root && \
    chown -R sterling:0 /app-root && \
    chmod -R g=u /app-root

# 2. Upgrade system packages
RUN dnf update -y --skip-broken --nobest &&\
    dnf upgrade -y --skip-broken --nobest &&\
    dnf install vim jq git -y &&\
    dnf clean all

# 3. Upgrade pip, install wheel, then install Python modules
USER sterling

COPY --chown=sterling:root install /tmp/install
RUN ls -lrt /tmp/install
RUN python3 -m pip install --no-cache-dir --upgrade pip setuptools wheel &&\
    pip3 install -r /tmp/install/requirements.txt --find-links /tmp/install

# 4. Install required tools & Ansible collections
USER root

RUN umask 0002 && \
    bash -x /tmp/install/install-helm.sh  --target-platform $ARCHITECTURE --helm-version $HELM_VERSION && \
    bash -x /tmp/install/install-ibmcloud.sh  --target-platform $ARCHITECTURE --ibmcli-version $IBMCLI_VERSION && \
    bash -x /tmp/install/install-oc-client.sh  --target-platform $ARCHITECTURE && \
    bash -x /tmp/install/install-oc-ibmpak.sh  --target-platform $ARCHITECTURE --ibmpak-version $IBMPAK_VERSION && \
    bash -x /tmp/install/install-rclone.sh --target-platform $ARCHITECTURE

RUN rm -rf /tmp/install && \
    rm -f /app-root/.wget-hsts /app-root/README.md /app-root/LICENSE && \
    rm -rf /tmp/*

# 5. Clone ansible-ibm-sterling repository
USER sterling
WORKDIR /app-root
RUN git clone https://github.com/ibm-sterling-devops/ansible-ibm-sterling.git 
#&& \
#    chown -R sterling:0 /app-root/ansible-ibm-sterling && \
#    chmod -R g=u /app-root/ansible-ibm-sterling


# 7. Setup working environment
USER sterling
WORKDIR /app-root
#ENTRYPOINT ["/tini", "--"]
CMD ["/bin/bash"]