#!/bin/bash
set -euxo pipefail

cd /tmp
sudo apt update

if [ -n "$(uname -a | grep Ubuntu)" ]; then
    sudo ubuntu-drivers autoinstall

    # Clash for Linux
    set +e
    wget -N https://github.com/Dreamacro/clash/releases/download/v0.19.0/clash-linux-amd64-v0.19.0.gz
    while [ $? -ne 0 ]; do
        wget -N https://github.com/Dreamacro/clash/releases/download/v0.19.0/clash-linux-amd64-v0.19.0.gz
    done
    set -e
    gzip -d -f clash-linux-amd64-v0.19.0.gz
    sudo mv clash-linux-amd64-v0.19.0 /usr/bin/clash #普通用户首次使用sudo需要输入密码，输入正确没有任何反馈
    sudo chmod +x /usr/bin/clash

    clash -v #如返回（Clash v0.18.0 linux amd64 Fri Feb 21 12:42:08 UTC 2020）即成功

    sudo setcap cap_net_bind_service=+ep /usr/bin/clash

    mkdir -p ~/.config/clash
    cd ~/.config/clash
    touch config.yaml
    wget -O ~/.config/clash/config.yaml http://aelr.cc/link/c5b8JHoR8UObj3Hu\?clash\=1
    perl -p -i -e "s/mode: rule/mode: Rule/g" ~/.config/clash/config.yaml

    set +e
    clash -t
    while [ $? -ne 0 ]; do
        clash -t
    done
    set -e

    sudo touch /etc/systemd/system/clash.service
    sudo bash -c "cat << EOF > /etc/systemd/system/clash.service 
[Unit]
Description=clash daemon

[Service]
Type=simple
User=$(whoami)
ExecStart=/usr/bin/clash -d /home/$(whoami)/.config/clash/
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF"
    sudo systemctl daemon-reload
    sudo systemctl start clash.service
    sudo systemctl enable clash.service
    xdg-open http://yacd.haishan.me

    export http_proxy="http://127.0.0.1:7890"
    export https_proxy="http://127.0.0.1:7890"
    export no_proxy="localhost, 127.0.0.1"
    cd -
else
    sudo apt install snapd
fi

set +e
wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
while [ $? -ne 0 ]; do
    wget -N https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
done
set -e
sudo apt install ./google-chrome-stable_current_amd64.deb

sudo apt-get install tilda -y
sudo snap install android-studio --classic
sudo snap install --classic code # or code-insiders
sudo snap install --classic neovide

sudo apt install curl git net-tools openssh-server hfsprogs tree fzf autojump neovim git-lfs -y

sudo apt install java-common -y
# Java SE 7
set +e
wget -N https://download.java.net/openjdk/jdk7u75/ri/openjdk-7u75-b13-linux-x64-18_dec_2014.tar.gz
while [ $? -ne 0 ]; do
    wget -N https://download.java.net/openjdk/jdk7u75/ri/openjdk-7u75-b13-linux-x64-18_dec_2014.tar.gz
done
set -e
# Java SE 8
wget -N https://download.java.net/openjdk/jdk8u40/ri/openjdk-8u40-b25-linux-x64-10_feb_2015.tar.gz
# Java SE 9
wget -N https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_linux-x64_bin.tar.gz
# Java SE 10
wget -N https://download.java.net/java/GA/jdk10/10.0.2/19aef61b38124481863b1413dce1855f/13/openjdk-10.0.2_linux-x64_bin.tar.gz
# Java SE 11
wget -N https://download.java.net/java/GA/jdk11/9/GPL/openjdk-11.0.2_linux-x64_bin.tar.gz
# Java SE 12
wget -N https://download.java.net/java/GA/jdk12.0.2/e482c34c86bd4bf8b56c0b35558996b9/10/GPL/openjdk-12.0.2_linux-x64_bin.tar.gz
# Java SE 13
wget -N https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_linux-x64_bin.tar.gz

sudo mkdir -p /usr/lib/jvm

# Extract all downloaded jdk files
sudo tar -xvzf openjdk-7u75-b13-linux-x64-18_dec_2014.tar.gz -C /usr/lib/jvm
sudo tar -xvzf openjdk-8u40-b25-linux-x64-10_feb_2015.tar.gz -C /usr/lib/jvm
sudo tar -xvzf openjdk-9.0.4_linux-x64_bin.tar.gz -C /usr/lib/jvm
sudo tar -xvzf openjdk-10.0.2_linux-x64_bin.tar.gz -C /usr/lib/jvm
sudo tar -xvzf openjdk-11.0.2_linux-x64_bin.tar.gz -C /usr/lib/jvm
sudo tar -xvzf openjdk-12.0.2_linux-x64_bin.tar.gz -C /usr/lib/jvm
sudo tar -xvzf openjdk-13_linux-x64_bin.tar.gz -C /usr/lib/jvm

# Install Java and Java Compiler to Environment
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-se-7u75-ri/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-se-7u75-ri/bin/javac 1
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-se-8u40-ri/bin/java 2
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-se-8u40-ri/bin/javac 2
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-9.0.4/bin/java 3
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-9.0.4/bin/javac 3
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-10.0.2/bin/java 4
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-10.0.2/bin/javac 4
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-11.0.2/bin/java 5
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-11.0.2/bin/javac 5
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-12.0.2/bin/java 6
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-12.0.2/bin/javac 6
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/jdk-13/bin/java 7
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk-13/bin/javac 7

# Verify Java and Java Compiler Installation
# check if java command is pointing to correct path in system
update-alternatives --display java
update-alternatives --display javac

# List all environment variables
update-alternatives --get-selections
# or
update-alternatives --get-selections | grep java
# or
update-alternatives --get-selections | grep ^java
cat <<'EOF' | sudo tee /etc/profile.d/java_home_env.sh >/dev/null

# Set JDK installation directory according to selected Java compiler

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
export JDK_HOME=${JAVA_HOME}
export JRE_HOME=${JDK_HOME}/jre/
export PATH=${JAVA_HOME}/bin:${PATH}

EOF

sudo apt-get install -y axel git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 libncurses5-dev lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig python
sudo snap install git-repo --devmode

git clone https://github.com/akhilnarang/scripts || true
cd scripts
unset http_proxy
unset https_proxy
unset HTTP_PROXY
unset HTTPS_PROXY
./setup/android_build_env.sh
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1
if [ -n "$(uname -a | grep Ubuntu)" ]; then
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.8 2
else
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.7 2
fi

git config --global user.email "fjjohnchen@qq.com"
git config --global user.name "fjjohnchen"

# zsh
sudo apt-get install zsh -y
if [ -n "$(uname -a | grep Ubuntu)" ]; then
    export http_proxy="http://127.0.0.1:7890"
    export https_proxy="http://127.0.0.1:7890"
    export no_proxy="localhost, 127.0.0.1"
fi
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
