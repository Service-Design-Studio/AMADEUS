#!/bin/bash
# Install python
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.9 -y
sudo apt install python3-pip python3.9-distutils -y
python3.9 -m pip install pip
python3.9 -m pip install flask
python3.9 -m pip install transformers
python3.9 -m pip install torch

# Git clone
git init
git remote add -f origin https://github.com/Service-Design-Studio/final-project-group-5-amadeus.git
git config core.sparseCheckout true
echo "lib/assets/zero_shot_categoriser.py" >>.git/info/sparse-checkout
git pull origin main

# Run Flask app
nohup python3.9 lib/assets/zero_shot_categoriser.py > flask_log.txt 2>&1 &

# Setup socket
curl -O https://portal.socketxp.com/download/linux/socketxp && chmod +wx socketxp && sudo mv socketxp /usr/local/bin

sudo socketxp login # [your socketxp auth id]
sudo nohup socketxp connect http://localhost:5000 > socket_log.txt 2>&1 &
