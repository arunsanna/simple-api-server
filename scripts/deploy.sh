#!bin/bash

#variables

KEYPAIR="api-server-$(date "+%s")"

echo "provide the path of you ssh public key"
read LOCAL_KEYPAIR_PATH

echo "provide the profile name that you configured in aws configure"
read PROFILE

# create ssh-key pair if there is not keypair in the local machine using awscli
aws ec2 import-key-pair --key-name $KEYPAIR --public-key-material file://$LOCAL_KEYPAIR_PATH --profile $PROFILE

# get the public ip-address
MY_IP=$(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}')

# run the terraform passing ip-address, profile, keyname
cd infra/
terraform apply --auto-approve -var="profile=$PROFILE" -var="keypair=$KEYPAIR" -var="myip-address=$MY_IP/32"