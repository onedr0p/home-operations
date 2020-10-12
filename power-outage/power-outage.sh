#!/usr/bin/env bash

# Get Absolute Path of the base repo
export REPO_ROOT=$(git rev-parse --show-toplevel)

# Set up log
LOGFILE="/var/logs/poweroff-$(date +'%Y.%m.%d-%H.%M.%S').log"

# Poweroff hosts
ansible-playbook \
    -i "${REPO_ROOT}/ansible/inventory/cluster/hosts.yaml" \
    "${REPO_ROOT}/ansible/playbook/power-outage.yaml" \
    2>&1 | tee -a "${LOGFILE}"
