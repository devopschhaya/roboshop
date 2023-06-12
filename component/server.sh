#/bin/bash

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=Devops-LabImage-Centos7" | jq '.Images[].ImageId'|sed -e 's/"//g')

echo "AMI id is $AMI_ID"

