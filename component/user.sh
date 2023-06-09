#!/bin/bash
echo "i am a catalogue"

COMPONENT=user
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

echo "configuring User:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOGFILE
stat $?

echo -n "Installing NodeJS :"
yum install nodejs -y &>> $LOGFILE
stat $?

id roboshop
if [ $? -ne 0 ] ; then 
echo "creating service account :"
useradd roboshop
stat $?
fi

echo -n "Downloading the $COMPONENT schema:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo "unzipping catalouge"
chown -R $APPUSER:$APPUSER /home/roboshop/
cd /home/${APPUSER}/
rm -rf ${COMPONENT} &>> $LOGFILE
unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE 
stat $?

echo -n "Moving catalog :"
cd /home/${APPUSER}/
mv $COMPONENT-main/ $COMPONENT
chown -R $APPUSER:$APPUSER /home/roboshop/$COMPONENT/
stat $?

echo -n "Installaing NPM :"
cd /home/${APPUSER}/${COMPONENT}
npm install  &>> $LOGFILE
stat $? 

echo -n "Updating Mongodb DNS:"
sed -i -e 's/REDIS_ENDPOINT/redis.roboshop.online/' -e 's/MONGO_ENDPOINT/mongodb.roboshop.online/' /home/${APPUSER}/${COMPONENT}/systemd.service 
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service 
#mv /etc/systemd/system/${COMPONENT}.service /home/${APPUSER}/${COMPONENT}/systemd.service
stat $?



echo -n " $COMPONENT restart :"
systemctl daemon-reload  &>> $LOGFILE
systemctl restart $COMPONENT &>> $LOGFILE
systemctl enable $COMPONENT  &>> $LOGFILE
#systemctl status $COMPONENT -l &>> $LOGFILE
stat $?


