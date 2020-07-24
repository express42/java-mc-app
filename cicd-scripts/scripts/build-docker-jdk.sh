#!/bin/bash

set -xe

#echo "Patching Gradle wrapper source repo"
#sed -i "s/http\\\:/https\\\:/g; s/services.gradle.org\\/distributions/nexus.trosbank.trus.tsocgen\\/repository\\/raw-distribs\\/jenkins/g" \
#    "gradle/wrapper/gradle-wrapper.properties"

echo "Running Docker containers"
docker run --rm \
    --name "${BUILD_TAG}-${STAGE_NAME}" \
    -e LANG -e LOCAL_USER="${USER}" -e LOCAL_USER_ID="$(id -u)" \
    -e GRADLE_OPTS -e GRADLE_USER_HOME \
    -e NEXUS_BASE_URL -e GROUP_ID \
    --volume "${GROUP_ID}-example_app-buildcache":"/home" \
    --volume "$(pwd)":"/src" \
    --net=host \
    -w /src \
    "${JDK_IMAGE}" \
    -c "/bin/sh ./gradlew -I ./cicd-scripts/templates/init.gradle $* "
