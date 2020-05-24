if ! [ -x "$(command -v brew)" ]; then
echo "brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
echo "oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "iterm2"
brew cask install iterm2

# 替换brew.git:
cd "$(brew --repo)"
git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

# 替换homebrew-core.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

# 替换homebrew-cask.git:
cd "$(brew --repo)/Library/Taps/homebrew/homebrew-cask"
git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git

# 应用生效
brew update

if [ -z "$HOMEBREW_BOTTLE_DOMAIN" ]
then
    echo "not defined"
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc
source ~/.zshrc
else 
    echo "defined"
fi

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
brew cask install unity-hub

echo "blender"
brew cask install blender

if [ -z "$ANDROID_HOME" ]
then
    echo "not defined"
cat <<"EOF" >> ~/.zshrc

export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$JAVA_HOME/bin:$PATH

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator       # can't run emulator without it
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export ANDROID_SDK_HOME=$HOME/Library/Android/sdk
export ANDROID_NDK_HOME=$HOME/Library/Android/sdk/ndk/18.1.5063045
export PATH=$ANDROID_NDK_HOME:$PATH
export PATH=$ANDROID_NDK_HOME/toolchains/aarch64-linux-android-4.9/prebuilt/darwin-x86_64/bin:$PATH
export PATH=$ANDROID_SDK_HOME/build-tools/26.0.3:$PATH
EOF
source ~/.zshrc
else 
    echo "defined"
fi

sdkmanager --list | grep -v system-images | awk '{print $1}' | xargs -I {} sdkmanager --install '{}'

defaults write com.apple.Finder AppleShowAllFiles true
killall Finder

sudo spctl --master-disable

defaults write com.apple.screencapture /tmp

chflags nohidden ~/Library/

defaults write com.googlecode.iterm2 HotkeyTermAnimationDuration -float 0.00001

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

echo "flutter"
brew tap MiderWong/flutter
brew install flutter
flutter doctor

brew cask install sogouinput
brew cask install adobe-acrobat-reader
