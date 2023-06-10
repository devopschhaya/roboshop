#!/bin/bash 
echo "I am a frontend"
COMPONENT=frontend

source components/common.sh

echo -e "*********** \e[35m $COMPONENT Installation has started \e[0m ***********"

echo -n "Installing Nginx :"
yum install nginx -y  &>> $LOGFILE
stat $?
