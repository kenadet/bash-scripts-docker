#!/bin/bash

# Description: Script to create image for maven project with spotify docker plugin
# Usage:
# First do: chmod +x run-image-build.sh
# Subsequently do: ./run-image-build.sh [project directory]

function cmd {
   (echo "Compiling jar and creating docker image for $1" \
          && cd $1 && mvn clean package -Dmaven.test.skip=true docker:build && \
          echo "Complete creating docker image for $1" && cd ..)
}

if [ $# == 0 ]
then
      (echo "Compiling jars and building all docker images" \
       && mvn clean package docker:build -Dmaven.test.skip=true \
       && echo "Complete building docker images")
elif [ $# == 1 ]
then 
    cmd "$1"
else
    echo "Wrong arguments, usage: ./run-image-build [project directory]"
fi

