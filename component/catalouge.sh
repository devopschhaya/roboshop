#!/bin/bash
echo "i am a catalouge"

COMPONENT=catalouge
LOGFILE="/tmp/${COMPONENT}.log"
ID=$(id -u)
APPUSER=roboshop

stat() {
if [ $1 -ne 0 ] ; then
echo -e "\e[32m install has error or failed \e[0m"
else
echo -e "\e[31m Install Succeesful \e[0m"

fi
}

#source components/common.sh

echo configuring Catalouge
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOGFILE
stat $?

yum install nodejs -y &>> $LOGFILE

stat $?

id roboshop
if [ $? -ne 0 ] ; then 
echo "creating service account"
useradd roboshop
stat $?
fi

echo -n "Downloading the $COMPONENT schema:"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"
stat $?


echo "unzipping catalouge"
cd /home/${APPUSER}/
unzip -o /tmp/catalogue.zip  &>> $LOGFILE 
stat $?

echo -n "Moving catalog :"
mv $COMPONENT-main/ $COMPONENT
chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT/
stat $?
# cd /home/roboshop/catalouge
# npm install
#stat $? 

