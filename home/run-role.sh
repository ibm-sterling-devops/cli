#!/bin/bash

if [ -e "/work/additional-configs" ]; then
  cp /work/additional-configs/* /app-root/configs/
fi

source /app-root/env.sh

# Useful for debugging permission issues
# oc whoami
# oc auth can-i --list

python3 /app-root/custom-script.py

export ROLE_NAME=$1
#ansible-playbook ibm.mas_devops.run_role
cd /ansible-ibm-sterling
ansible-palybook roles/setup-cd.yml

rc=$?

# do something here
exit $rc
