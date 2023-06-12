#!/bin/bash 

COMPONENT=mongodb
LOGFILE="/tmp/${COMPONENT}.log"

stat() {
if [ $1 -ne 0 ] ; then
echo -e "\e[32m install has error or failed \e[0m"
else
echo -e "\e[31m Install Succeesful \e[0m"

fi
}
