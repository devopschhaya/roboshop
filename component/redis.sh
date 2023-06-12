#!/bash/bin
echo this is radish

COMPONENT = radish
LOGFILE= "/tmp/${COMPONENT}.log"

echo -n "installing redis"
curl -L https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo -o /etc/yum.repos.d/$COMPONENT.repo
yum install $COMPONENT-6.2.11 -y

 echo -n "Enabling the DB visibility :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/$COMPONENT.conf
stat $?

echo -n "Starting $COMPONENT : "
systemctl daemon-reload $COMPONENT     &>> $LOGFILE
systemctl enable $COMPONENT      &>> $LOGFILE
systemctl restart $COMPONENT       &>> $LOGFILE
stat $?