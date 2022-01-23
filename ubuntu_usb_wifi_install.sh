#!/bin/bash
set -euxo pipefail

cd /tmp
echo "$(whoami)  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$(whoami)
sudo systemctl stop unattended-upgrades

sudo apt update
sudo apt-mark hold linux-image-generic linux-headers-generic
sudo apt install build-essential git dkms -y
set +e
git -C rtl8821CU pull || git clone https://github.com/brektrou/rtl8821CU.git
while [ $? -ne 0 ]; do
    git -C rtl8821CU pull || git clone https://github.com/brektrou/rtl8821CU.git
done
set -e
cd rtl8821CU
chmod +x dkms-install.sh
sudo ./dkms-install.sh
sudo modprobe 8821cu
sudo reboot
