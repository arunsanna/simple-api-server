#!bin/bash

# create ssh-key pair if there is not keypair in the local machine using awscli
aws ec2 import-key-pair --key-name "api-server" --public-key-material file://~/.ssh/my-key.pub

# get the public ip-address

# run the terraform passing ip-address, profile, keyname
 terraform apply --auto-approve -var="require-bastion=true" -var="profile=$PROFILE" -var="keyname-$keyname" 