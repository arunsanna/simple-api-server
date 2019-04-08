#!bin/bash

# download and install git
sudo yum -y install git &&

# install pip
sudo easy_install pip &&

# install flask restful-api
sudo pip install flask-restful &&

# clone the repo
sudo git clone https://github.com/arunsanna/simple-api-server.git /opt/ &&

# now run the app code.
nohup python /opt/app/app.py 2>&1 &