
#!/usr/bin/env bash

set -e

# add custom sripts to quickly start a cloud developer environment
echo "source /home/ubuntu/.glueopsrc" >> /home/ubuntu/.bashrc

#install docker per instructions: https://docs.docker.com/engine/install/ubuntu/ 
sudo apt-get update
#https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-connect-set-up.html
sudo apt-get install ec2-instance-connect -y
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
#tmux and jq are used by the scripts we have in .glueopsrc
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin tmux jq -y
sudo groupadd -f docker
sudo usermod -aG docker $USER
