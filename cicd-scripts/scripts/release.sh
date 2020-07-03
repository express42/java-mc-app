#!/bin/bash

vars=(GROUP_ID PROJECT ARTIFACT_PATH ARTIFACT_VERSION NEXUS_BASE_URL NEXUS_USER NEXUS_PASS NEXUS_REPOSITORY)

for var in ${vars[*]}
do
if [[ -z ${!var} ]]; then
  >&2 echo "Environment variable $var is not set"
  >&2 echo "Required variables:"
  >&2 printf '%s\n' "${vars[@]}"
  exit 1
fi
done

export NEXUS_REPOSITORY="${NEXUS_REPOSITORY,,}"
export URL_GROUP_ID="${GROUP_ID,,}"
# Double comma in var-name means "lowercase var value" in Bash 4.x

mvn --settings /tmp/maven-settings.xml \
   deploy:deploy-file -B \
  -DgroupId="${GROUP_ID}" \
  -DrepositoryId="nexus" \
  -DartifactId="${PROJECT}" \
  -DgeneratePom="false" \
  -Dfile=${ARTIFACT_PATH} \
  -Dclassifier="distributive" \
  -Dversion="${ARTIFACT_VERSION}" \
  -D url="http://${NEXUS_BASE_URL}/repository/${NEXUS_REPOSITORY}" \
  -X
