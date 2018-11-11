#!/bin/bash

set -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
LOCAL_REPO_DIR="${DIR}/maven-repo"

rm -rf ${LOCAL_REPO_DIR}

echo -n "Download dependencies to ${LOCAL_REPO_DIR} ... "

output=$( ./mvnw -Dmaven.repo.local=${LOCAL_REPO_DIR} dependency:go-offline 2>&1 | tee mvn_process.log ) 

if [ $? -ne 0 ]; then
  echo "[Failed]"
  echo -e "Command output:\n ${output}"
  exit 1
else
  echo "[Done]"
fi

echo -n "Create dependencies tar file ... "
output=$( tar -cvf dependencies.tar ${LOCAL_REPO_DIR} 2>&1  )

if [ $? -ne 0 ]; then
  echo "[Failed]"
  echo -e "Command output:\n ${output}"
  exit 1
else
  echo "[Done]"
fi
