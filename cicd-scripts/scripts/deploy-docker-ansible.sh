#!/bin/bash
docker login -u "${NEXUS_USER}" -p "${NEXUS_PASS}" "${NEXUS_BASE_URL}"

export BASE_DIR="/tmp/deploy"

docker run --rm \
--name "${BUILD_TAG}-${STAGE_NAME//\ /}" \
-e LANG -e "LOCAL_USER=${USER}" -e "LOCAL_USER_ID=$(id -u)" -e SSH_USER \
-e "ANSIBLE_FORCE_COLOR=true" -e ANSIBLE_INVENTORY_FILE \
-e ANSIBLE_EXTRA_VARS \
-e NEXUS_USER -e NEXUS_PASS -e GROUP_ID -e PROJECT \
-e NEXUS_BASE_URL -e NEXUS_REPOSITORY \
--volume "${SSH_KEY_FILE}:/tmp/id_rsa:ro" \
--volume "$(pwd):${BASE_DIR}" \
-w ${BASE_DIR}/ansible "${ANSIBLE_IMAGE}" \
-c "/bin/bash -xe ${BASE_DIR}/jenkins/scripts/deploy-run-ansible.sh"
