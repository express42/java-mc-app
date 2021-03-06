#!/bin/bash
set -xe

#vars=(SONAR_IMAGE SONAR_PROJECT_KEY SONAR_PROJECT_NAME)

#for var in ${vars[*]}
#do
#if [[ -z ${!var} ]]; then
#  >&2 echo "Environment variable $var is not set"
#  >&2 echo "Required variables:"
#  >&2 printf '%s\n' "${vars[@]}"
#  exit 1
#fi
#done

docker run --rm \
--name $BUILD_TAG-${STAGE_NAME}  \
-e LANG -e LOCAL_USER=$USER -e LOCAL_USER_ID=`id -u` \
-e APP_VERSION=$ARTIFACT_VERSION -e TOKEN \
-e SONAR_PROJECT_KEY=$SONAR_PROJECT_KEY -e SONAR_PROJECT_NAME=$SONAR_PROJECT_NAME \
--volume "$(pwd):/tmp/src" \
$SONAR_IMAGE \
-c '/bin/bash -xe /tmp/src/jenkins/scripts/sonar.sh'
