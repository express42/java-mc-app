#!/bin/bash

ansible-playbook --user ${SSH_USER} \
 --private-key /tmp/id_rsa --ssh-common-args '-o StrictHostKeyChecking=no' \
 -i ${ANSIBLE_INVENTORY_FILE} playbooks/deploy.yml \
 -vv --diff ${ANSIBLE_EXTRA_VARS}
