#!/bin/bash

DEPENDENCIES_OUTPUT_FILE=dependencies-output.txt

echo -n "Output dependencies list to file ... "

output=$( ./mvnw -Doutput.file.name=${DEPENDENCIES_OUTPUT_FILE} dependency:go-offline 2>&1 ) 

if [ $? -ne 0 ]; then
  echo "[Failed]"
  echo -e "Command output:\n ${output}"
else
  echo "[Done]"
fi

echo -n "Create dependencies tar file ... "
output=$( awk -F':' '/\.jar/ { print $NF  }' ${DEPENDENCIES_OUTPUT_FILE} | tar -cvf dependencies.tar -T - 2>&1  )

if [ $? -ne 0 ]; then
  echo "[Failed]"
  echo -e "Command output:\n ${output}"
else
  echo "[Done]"
fi
