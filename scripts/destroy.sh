#!bin/bash

cd infra/
KEYPAIR=$(terraform output keypair)
PROFILE=$(terraform output profile)
MY_IP=$(terraform output myip-address)

terraform destroy --auto-approve -var="profile=$PROFILE" -var="keypair=$KEYPAIR" -var="myip-address=$MY_IP" &&

aws ec2 delete-key-pair --key-name $KEYPAIR --profile $PROFILE