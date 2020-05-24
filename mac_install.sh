echo "brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "iterm2"
brew cask install iterm2

echo "google-chrome"
brew cask install google-chrome

echo "gnu"
brew install coreutils findutils gnu-tar gnu-sed gawk gnutls gnu-indent gnu-getopt grep

echo "bazel"
brew install bazel

echo "cmake"
brew install cmake

echo "ninja"
brew install ninja

echo "node"
brew install node

echo "opencv@3"
brew install opencv@3

echo "jadx"
brew install jadx

echo "macvim"
brew install macvim

echo "ffmpeg"
brew install ffmpeg

echo "proguard"
brew install proguard

echo "flutter"
brew tap MiderWong/flutter
brew install flutter

echo "mono"
brew install mono

echo "python"
brew install python    #安装python

echo "clang-format"
brew install clang-format

echo "jd-gui"
brew cask install jd-gui

echo "visual-studio-code"
brew cask install visual-studio-code

echo "visual-studio"
brew cask install visual-studio

echo "sublime-text"
brew cask install sublime-text

echo "dingtalk"
brew cask install dingtalk

echo "android-studio"
brew cask install android-studio

echo "clion"
brew cask install clion

echo "pycharm-ce"
brew cask install pycharm-ce

echo "intellij-idea-ce"
brew cask install intellij-idea-ce

echo "sourcetree"
brew cask install sourcetree

echo "appcleaner"
brew cask install appcleaner

echo "v2rayu"
brew cask install v2rayu

echo "shadowsocksx-ng-r"
brew cask install shadowsocksx-ng-r

echo "xmind-zen"
brew cask install xmind-zen

echo "clashx"
brew cask install clashx

echo "github"
brew cask install github

echo "macdown"
brew cask install macdown

echo "unity"
brew cask install unity

echo "blender"
brew cask install blender

if [[ ! -v ANDROID_HOME ]]; then
    echo "ANDROID_HOME is not set"
cat <<"EOF" >> ~/.zshrc
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH:$JAVA_HOME/bin

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator       # can't run emulator without it
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

export ANDROID_SDK_HOME=$HOME/Library/Android/sdk
export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk-bundle
export PATH=$ANDROID_NDK_PATH:$PATH
export PATH=$ANDROID_SDK_HOME/build-tools/26.0.3:$PATH
EOF
elif [[ -z "$ANDROID_HOME" ]]; then
    echo "ANDROID_HOME is set to the empty string"
else
    echo "ANDROID_HOME has the value: $ANDROID_HOME"
fi

source ~/.zshrc


