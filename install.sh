#!/bin/sh
# Name: Monica Lin
# Update: 09/10/2020
DEBUG_MODE=true
chmod +x install.sh
#sudo add-apt-repository universe
read -p "Does this machine have NVidia Graphic Card (yes/no)? " NVIDIA_CARD
#echo $NVIDIA_CARD
if [ $NVIDIA_CARD = "yes" ]; then
    echo "Installing Nvidia Driver 440..."
    if [ DEBUG_MODE = "false" ]; then
        sudo apt-get update
        sudo apt-get install -y vim git git-lfs openssh-server build-essential stress htop psensor curl net-tools nmap python-dev libusb-1.0-0-dev libudev-dev python3-pip
        sudo add-apt-repository -y ppa:graphics-drivers/ppa
        sudo apt-get install -y nvidia-driver-440
        sudo apt-get install -y nvidia-cuda-toolkit
    fi
else
    echo "Please make sure you have Nvidia Graphic Card before installing QCraft basic installation."
fi
read -p "Does this machine have NVidia Driver (yes/no)? " NVIDIA_DRIVER
gpu_install=$(prime-select query)
if [ $NVIDIA_DRIVER = "yes" ]; then
    if [ $gpu_install = "nvidia" ]; then
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
    else
        echo "Please make sure you have Nvidia Graphic Card and Nvidia Driver before installing QCraft basic installation."
        echo "If you have install Nvidia Driver please check ####nvidia-smi#### to make sure everythings are working"
        echo "If you just finish installing Nvidia Driver please try ####sudo reboot#### to make sure everythings are working"
        exit
    fi
else
    echo "Please make sure you have Nvidia Graphic Card and Nvidia Driver before installing QCraft basic installation."
    exit
fi


