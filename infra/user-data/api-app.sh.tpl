#!bin/bash

# download and install git
sudo yum -y install git &&

# install pip
sudo easy_install pip &&

# install flask restful-api
echo "installing restful-api" >> app.out &&
sudo pip install flask-restful &&

# clone the repo
echo "cloning the repo" >> app.out &&
sudo git clone https://github.com/arunsanna/simple-api-server.git /opt/ &&
echo "completed cloning" >> app.out &&

# now run the app code.
nohup python /opt/app/app.py 2>&1 &