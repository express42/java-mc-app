#!/bin/bash
set -xe

#vars=(GROUP_ID PROJECT ARTIFACT_PATH ARTIFACT_VERSION NEXUS_BASE_URL NEXUS_USER NEXUS_PASS MAVEN_IMAGE NEXUS_REPOSITORY)

#for var in ${vars[*]}
#do
#if [[ -z ${!var} ]]; then
#  >&2 echo "Environment variable $var is not set"
#  >&2 echo "Required variables:"
#  >&2 printf '%s\n' "${vars[@]}"
#  exit 1
#fi
#done

[ -d ~/.m2/repository ] || mkdir -p ~/.m2/repository

docker run --rm \
--name $BUILD_TAG-${STAGE_NAME}  \
-e LANG -e LOCAL_USER=$USER -e LOCAL_USER_ID=`id -u` -e NEXUS_BASE_URL -e NEXUS_USER -e NEXUS_PASS -e NEXUS_REPOSITORY -e ARTIFACT_VERSION -e USER_FOLDER -e ARTIFACT_PATH -e PROJECT -e GROUP_ID \
-v ~/.m2/repository:/tmp/.m2/repository \
-v $(pwd)/jenkins/scripts/release.sh:/tmp/release.sh \
-v $(pwd)/build/libs:/libs \
-v $(pwd)/jenkins/templates/maven-settings.xml:/tmp/maven-settings.xml \
-w /tmp/ \
$MAVEN_IMAGE \
-c '/bin/bash -xe /tmp/release.sh'
