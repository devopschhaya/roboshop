#!/bin/bash 
echo "I am a frontend"
COMPONENT=frontend
ID=$(id -u)
if [ $ID -ne 0 ] ; then
echo -e "\e[31m this script is expected to be run by a root user \e[0m"
exit 1

fi

echo -n "Installing Nginx :"
yum install nginx -y  &>> "/tmp/${COMPONENT}.LOG"
if [$? -ne 0]; then
echo -e "\e[32m install has error or failed \e[0m"
else
echo -e "\e[31m Install Succeesful \e[0m"
fi
exit 2
