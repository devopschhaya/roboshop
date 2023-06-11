#!/bin/bash 
echo "I am a frontend"
COMPONENT=frontend
LOGFILE="/tmp/${COMPONENT}.LOG"
ID=$(id -u)
if [ $ID -ne 0 ] ; then
echo -e "\e[31m this script is expected to be run by a root user \e[0m"
exit 1
fi

stat() {
if [ $1 -ne 0 ] ; then
echo -e "\e[32m install has error or failed \e[0m"
else
echo -e "\e[31m Install Succeesful \e[0m"

fi
}

echo -n "Installing Nginx :"
yum install nginx -y  &>> "/tmp/${COMPONENT}.LOG"

stat $?
echo -n "Installing $COMPONENT :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?
echo -n "unzip frontend component"
unzip /tmp/${COMPONENT}.zip   &>> $LOGFILE
mv $COMPONENT-main/*  .
mv static/* . 
rm -rf ${COMPONENT}-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $? 