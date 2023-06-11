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

source components/common.sh

echo -e "*********** \e[35m $COMPONENT Installation has started \e[0m ***********"

echo -n  "Configuring the $COMPONENT repo :"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $? 

echo -n "Installing $COMPONENT : "
yum install -y $COMPONENT-org   &>> $LOGFILE
stat $? 

echo -n "Enabling the DB visibility :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $? 

echo -n "Starting $COMPONENT : "
systemctl daemon-reload mongod      &>> $LOGFILE
systemctl enable mongod      &>> $LOGFILE
systemctl restart mongod       &>> $LOGFILE
stat $?
