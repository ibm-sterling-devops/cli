#!/bin/bash

if [ -e "/work/additional-configs" ]; then
  cp /work/additional-configs/* /app-root/configs/
fi

if [ -e "/work/entitlement/entitlement.lic" ]; then
  cp /work/entitlement/entitlement.lic /app-root/configs/entitlement.lic
fi

source /app-root/env.sh

# Useful for debugging permission issues
# oc whoami
# oc auth can-i --list

python3 /app-root/custom-script.py

cd /ansible-ibm-sterling

ansible-playbook -i environments/hosts.dev -u root playbooks/setup-cd.yml

rc=$?

# do something here

exit $rc
