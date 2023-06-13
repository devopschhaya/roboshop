#/bin/bash

COMPONENT=$1

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId'|sed -e 's/"//g')
SG_ID=$(aws ec2 describe-security-groups --filters "Name=group-name,Values=devops54" | jq '.SecurityGroups[].GroupId'|sed -e 's/"//g')

echo -e "AMI id is $AMI_ID"
echo -e "Security group id is $SG_ID"

echo -e "Launch instane"

aws ec2 run-instances  --image-id ${AMI_ID}  --instance-type t2.micro  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT]" | jq .
    
    

