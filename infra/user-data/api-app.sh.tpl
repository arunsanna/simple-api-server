#!bin/bash

# download and install git
sudo yum -y install git &&

# install pip
sudo easy_install pip &&

# install flask restful-api
echo "installing restful-api" >> /tmp/app.out &&
sudo pip install flask-restful &&

# clone the repo
echo "cloning the repo" >> /tmp/app.out &&

sudo git clone https://github.com/arunsanna/simple-api-server.git /opt/ &&

echo "completed cloning" >> /tmp/app.out &&

# now run the app code.
echo "running the python api server" >> /tmp/app.out &&
nohup python /opt/app/app.py 2>&1 &
