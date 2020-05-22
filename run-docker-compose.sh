#!/bin/bash

# Description: Script to execute docker-compose with precaution after image build
# Usage:
# First do: chmod +x run-docker-compose.sh
# Subsequently do: ./run-docker-compose.sh [service-name / usage] [recreate / scale [num] / down] where [args] are optional 

function cmd_up {
   docker-compose up $1
}

function cmd_down {
   docker-compose rm -fs $1
}

if [ $# == 0 ]
then
   cmd_up " "
   exit $?

elif [ $# == 1 -a $1 == "up" ]
then
    cmd_up " "
    exit $?

elif [ $# == 1 -a $1 == "no-recreate" ]
then
  cmd_up "--no-build --no-recreate"
  exit $?

elif [ $# == 1 -a $1 == "usage" ]
then 
   echo -e "First do: chmod +x run-docker-compose.sh \nSubsequently do: ./run-docker-compose.sh [service-name / usage] \
           [recreate / scale [num] / down] where [args] are optional"
   exit $?

elif [ $# == 1 -a $1 == "down" ]
then 
   read -n 1 -p "This will shut down all services, are sure this is what you want to do (y/n)?:" answer
   if [ "$answer" == "y" ]
   then
      cmd_down " "
      exit $?
   else 
      echo -e "\nCommand not executed"
      exit 1
   fi

elif [ $# == 1 -a $1 != "usage" ]
then
   cmd_up "$1"
   exit $?

elif [ $# == 2 -a $2 == "up" ]
then
   cmd_up "$1"
   exit $?

elif [ $# == 2 -a $2 == "recreate" ]
then
   cmd_up "--force-recreate -d $1"
   exit $?

elif [ $# == 2 -a $2 == "down" ]
then 
   read -n 1 -p  "This will shut down $1, are sure this is what you want to do (y/n)?:" answer
   if [ "$answer" == "y" ]
   then
      cmd_down "$1"
      exit $?
   else 
      echo -e "\nCommand not executed"
      exit 1
   fi

elif [ $# == 3 -a $2 == "scale" ] 
then 
   echo "Scaling $1 to $3"
   cmd_up "--scale $1=$3"
   exit $?

else  
   echo "Invalid parameter, Usage: ./run-docker-compose.sh [service-name] [recreate / scale [num] / down]" 
fi

