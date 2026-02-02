#!/bin/bash
set -e

echo "=== Fixing permissions for default user (1001) ==="

# Create Ansible directories with correct permissions
mkdir -p /opt/app-root/src/.ansible/tmp \
         /opt/app-root/src/.ansible/collections \
         /opt/app-root/src/.config \
         /opt/app-root/src/.ibm-pak \
         /opt/app-root/src/.bluemix \
         /opt/app-root/src/.docker

# Set correct permissions (775 for directories, readable/writable by user and group)
chmod -R 775 /opt/app-root/src/.ansible \
             /opt/app-root/src/.config \
             /opt/app-root/src/.ibm-pak \
             /opt/app-root/src/.bluemix \
             /opt/app-root/src/.docker

# Set correct ownership (user 1001, group 0 - root group for OpenShift compatibility)
chown -R 1001:0 /opt/app-root/src

# Create workspace directory with proper permissions for Tekton
mkdir -p /workspace/shared-data
chown -R 1001:0 /workspace
chmod -R 775 /workspace

echo "=== Permissions fixed successfully ==="

# Made with Bob
