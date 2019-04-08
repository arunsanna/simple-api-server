#!bin/bash

#read the input to destroy or deploy

# create ssh-key pair if there is not keypair in the local machine using awscli
aws ec2 import-key-pair --key-name "api-server" --public-key-material file://~/.ssh/my-key.pub

# get the public ip-address
export MY-IP=$(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}')

# run the terraform passing ip-address, profile, keyname
terraform apply --auto-approve -var="require-bastion=true" -var="profile=$PROFILE" -var="keyname-$keyname" 

#cleanup the key