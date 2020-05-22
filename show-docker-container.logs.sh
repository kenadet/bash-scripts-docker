#!/bin/bash

# Description: Script to show docker container logs
# Usage:
# First do: chmod +x ./show-docker-container-logs
# Subsequently do: ./show-docker-container-logs [container-name or id]

if [ $# == 1 ]
then
   docker logs -f $1
else
   echo "Wrong arguments, usage: ./show-docker-container-logs [container-name or id]"
fi


