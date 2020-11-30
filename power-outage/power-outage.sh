#!/usr/bin/env bash

# Set up log
log_file="/var/logs/poweroff-$(date +'%Y.%m.%d-%H.%M.%S').log"

# Poweroff hosts
ansible-playbook \
  --private-key /config/server.key \
  -i "/app/ansible/inventory/cluster/hosts.yaml" \
  "/app/ansible/playbooks/power-outage.yaml" \
  2>&1 | tee -a "${log_file}"
