#!/bin/sh
# Name: Monica Lin
# Update: 09/1/2020
DEBUG_MODE=false
chmod +x install.sh
read -p "Two step installation script. Please key 1 or 2 to start installing QCRAFT INC. basic tools (1/2/N)?" STEP
case $STEP in
1)
    echo "Installing Nvidia Driver 440..."
    if [ DEBUG_MODE = "false" ]; then
        sudo apt-get update
        sudo apt-get install -y vim git git-lfs openssh-server build-essential stress htop psensor curl net-tools nmap python-dev libusb-1.0-0-dev libudev-dev python3-pip
        sudo add-apt-repository -y ppa:graphics-drivers/ppa
        sudo add-apt-repository -y ppa:graphics-drivers/ppa
        sudo apt-get install -y nvidia-cuda-toolkit
    fi
    echo "Pleae reboot and install step 2!"
    ;;
2)
    echo "Installing Nvidia Docker..."
    if [ DEBUG_MODE = "false" ]; then
        distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
        curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
        curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
        sudo apt-get update
        sudo apt-get install -y nvidia-container-toolkit
        sudo apt-get install -y nvidia-docker2
        sudo systemctl restart docker
        sudo systemctl restart docker.service
        usermod -a -G docker $USER
    fi
    ;;
N)
    echo "Unknown Step! Please retry again!"
    ;;
esac
