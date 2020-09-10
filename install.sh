#!/bin/sh
chmod +x install.sh
#sudo add-apt-repository universe
read -p "Does this machine have NVidia Graphic Card (yes/no)? " NVIDIA_CARD
#echo $NVIDIA_CARD
if [ $NVIDIA_CARD = "yes" ]; then
    echo "Installing Nvidia Driver 440 and Nvidia Docker..."
    sudo apt-get update
    sudo apt-get install -y vim git git-lfs openssh-server build-essential stress htop psensor curl net-tools nmap python-dev libusb-1.0-0-dev libudev-dev python3-pip
    sudo add-apt-repository -y ppa:graphics-drivers/ppa
    sudo apt-get install -y nvidia-driver-440
    sudo apt-get install -y nvidia-cuda-toolkit
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
    sudo apt-get update
    sudo apt-get install -y nvidia-container-toolkit
    sudo apt-get install -y nvidia-docker2
    sudo systemctl restart docker
    sudo systemctl restart docker.service
    usermod -a -G docker $USER
else
    echo "Please make sure you have Nvidia Driver before installing QCraft basic installation."
fi


