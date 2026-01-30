#!/bin/bash
set -e

echo "=== Fixing permissions for default user (1001) ==="

# Create Ansible directories with correct permissions
mkdir -p /opt/app-root/src/.ansible/tmp \
         /opt/app-root/src/.ansible/collections \
         /opt/app-root/src/.config \
         /opt/app-root/src/.ibm-pak \
         /opt/app-root/src/.bluemix

# Set correct permissions (775 for directories, readable/writable by user and group)
chmod -R 775 /opt/app-root/src/.ansible \
             /opt/app-root/src/.config \
             /opt/app-root/src/.ibm-pak \
             /opt/app-root/src/.bluemix

# Set correct ownership (user 1001, group 0)
chown -R 1001:0 /opt/app-root/src

echo "=== Permissions fixed successfully ==="

# Made with Bob
