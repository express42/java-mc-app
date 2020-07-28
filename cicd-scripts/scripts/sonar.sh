#!/bin/bash
cd /tmp/src/
cat <<EOG > /tmp/src/sonar.properties
sonar.projectKey=$SONAR_PROJECT_KEY
sonar.projectName=$SONAR_PROJECT_NAME
sonar.projectVersion=$ARTIFACT_VERSION
sonar.host.url=http://sonarqube.vtb-cicd.express42.io:9000/
sonar.modules=src
sonar.sources=main
sonar.java.binaries=../build/classes,../build/libs
sonar.tests=test
sonar.junit.reportPaths=../build/test-results/test
#sonar.jacoco.reportPaths=build/jacoco/test.exec
sonar.exclusions=*.png,*.img,*.gif,*.jpg,*.crt,*.cer,*.pem,*.key
EOG
sonar-scanner -X -Dproject.settings=/tmp/src/sonar.properties -Dlogin=$TOKEN
