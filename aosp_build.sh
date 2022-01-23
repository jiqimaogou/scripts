#!/bin/bash
set -exo pipefail

aospDownload() {
  local rom="$1" version="$2" aosp_device="$3"

  mkdir -p $rom/$version
  cd $rom/$version

  if [ ! -d "out" ]; then
    export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo'
    export GIT_SSL_NO_VERIFY=1
    case $rom in
    AOSP)
      unset http_proxy
      unset https_proxy
      unset HTTP_PROXY
      unset HTTPS_PROXY
      repo init -u https://mirrors.tuna.tsinghua.edu.cn/git/AOSP/platform/manifest -b $version --depth 1
      ;;
    PixelExperience)
      if [ -n "$(uname -a | grep Ubuntu)" ]; then
        export http_proxy="http://127.0.0.1:7890"
        export https_proxy="http://127.0.0.1:7890"
        export no_proxy="localhost, 127.0.0.1"
      fi
      repo init -u https://github.com/PixelExperience/manifest -b $version --depth 1
      ;;
    *)
      echo "invalid rom $rom"
      exit 1
      ;;
    esac

    cd .repo/repo
    git pull
    cd -

    # Sync
    set +e
    repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    while [ $? -ne 0 ]; do
      cd .
      repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
    done
    set -e
  fi

  case $rom in
  AOSP)
    case $version in
    android-12.1.0_r11)
      case $aosp_device in
      redfin)
        wget -N https://dl.google.com/dl/android/aosp/google_devices-redfin-sq3a.220705.003.a1-3b9815c2.tgz
        wget -N https://dl.google.com/dl/android/aosp/qcom-redfin-sq3a.220705.003.a1-8e4438cf.tgz
        ;;
      raven)
        wget -N https://dl.google.com/dl/android/aosp/google_devices-raven-sq3a.220705.003.a1-a4970437.tgz
        ;;
      *)
        echo "invalid device $aosp_device"
        exit 1
        ;;
      esac
      perl -p -i -e "s/asm-\d\.\d/asm-7.0/g" development/tools/mkstubs/Android.*
      ;;
    android-11.0.0_r48)
      case $aosp_device in
      redfin)
        wget -N https://dl.google.com/dl/android/aosp/google_devices-redfin-rq3a.211001.001-bd720345.tgz
        wget -N https://dl.google.com/dl/android/aosp/qcom-redfin-rq3a.211001.001-71f56923.tgz
        ;;
      *)
        echo "invalid device $aosp_device"
        exit 1
        ;;
      esac
      perl -p -i -e "s/asm-\d\.\d/asm-7.0/g" development/tools/mkstubs/Android.*
      ;;
    android-10.0.0_r1)
      echo 3 | sudo update-alternatives --config javac
      echo 3 | sudo update-alternatives --config java
      echo 1 | sudo update-alternatives --config python
      source /etc/profile.d/java_home_env.sh
      case $aosp_device in
      marlin)
        wget -N https://dl.google.com/dl/android/aosp/google_devices-marlin-qp1a.190711.019-9f58521d.tgz
        wget -N https://dl.google.com/dl/android/aosp/qcom-marlin-qp1a.190711.019-4394281d.tgz
        ;;
      *)
        echo "invalid device $aosp_device"
        exit 1
        ;;
      esac
      ;;
    android-9.0.0_r1)
      echo 3 | sudo update-alternatives --config javac
      echo 3 | sudo update-alternatives --config java
      echo 1 | sudo update-alternatives --config python
      source /etc/profile.d/java_home_env.sh
      case $aosp_device in
      marlin)
        wget -N https://dl.google.com/dl/android/aosp/google_devices-marlin-ppr1.180610.009-759c36bb.tgz
        wget -N https://dl.google.com/dl/android/aosp/qcom-marlin-ppr1.180610.009-9f8780d4.tgz
        ;;
      *)
        echo "invalid device $aosp_device"
        exit 1
        ;;
      esac
      ;;
    android-8.1.0_r1)
      echo 3 | sudo update-alternatives --config javac
      echo 3 | sudo update-alternatives --config java
      echo 1 | sudo update-alternatives --config python
      source /etc/profile.d/java_home_env.sh
      case $aosp_device in
      marlin)
        wget -N https://dl.google.com/dl/android/aosp/google_devices-marlin-opm1.171019.011-62249e06.tgz
        wget -N https://dl.google.com/dl/android/aosp/qcom-marlin-opm1.171019.011-ce710ec5.tgz
        ;;
      *)
        echo "invalid device $aosp_device"
        exit 1
        ;;
      esac
      ;;
    android-8.0.0_r1)
      echo 3 | sudo update-alternatives --config javac
      echo 3 | sudo update-alternatives --config java
      echo 1 | sudo update-alternatives --config python
      source /etc/profile.d/java_home_env.sh
      case $aosp_device in
      marlin)
        wget -N https://dl.google.com/dl/android/aosp/google_devices-marlin-opr6.170623.011-a7abe180.tgz
        wget -N https://dl.google.com/dl/android/aosp/qcom-marlin-opr6.170623.011-ec136afc.tgz
        ;;
      *)
        echo "invalid device $aosp_device"
        exit 1
        ;;
      esac
      ;;
    android-7.1.0_r1)
      echo 3 | sudo update-alternatives --config javac
      echo 3 | sudo update-alternatives --config java
      echo 1 | sudo update-alternatives --config python
      source /etc/profile.d/java_home_env.sh
      case $aosp_device in
      marlin)
        wget -N https://dl.google.com/dl/android/aosp/google_devices-marlin-nde63p-5058f8b6.tgz
        wget -N https://dl.google.com/dl/android/aosp/qcom-marlin-nde63p-aacc7d00.tgz
        ;;
      *)
        echo "invalid device $aosp_device"
        exit 1
        ;;
      esac
      ;;
    android-6.0.0_r1)
      echo 2 | sudo update-alternatives --config javac
      echo 2 | sudo update-alternatives --config java
      echo 1 | sudo update-alternatives --config python
      source /etc/profile.d/java_home_env.sh
      case $aosp_device in
      hammerhead)
        wget -N https://dl.google.com/dl/android/aosp/broadcom-hammerhead-mra58k-bed5b700.tgz
        wget -N https://dl.google.com/dl/android/aosp/lge-hammerhead-mra58k-25d00e3d.tgz
        wget -N https://dl.google.com/dl/android/aosp/qcom-hammerhead-mra58k-ff98ab07.tgz
        ;;
      *)
        echo "invalid device $aosp_device"
        exit 1
        ;;
      esac
      perl -p -i -e "s/grep '\^java/grep 'openjdk/g" build/core/main.mk
      perl -p -i -e "s/ART_HOST_CLANG := true/ART_HOST_CLANG := false/g" art/build/Android.common_build.mk
      perl -p -i -e "s/--no-proxy/--noproxy/g" prebuilts/sdk/tools/jack-admin
      perl -p -i -e "s/--no-proxy/--noproxy/g" prebuilts/sdk/tools/jack
      ;;
    *)
      echo "invalid version $version"
      exit 1
      ;;
    esac
    ;;
  esac

  if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    export LC_CTYPE=C
    export LANG=C
    ulimit -S -n 2048 # or whatever number you choose
  # elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  #   # Do something under GNU/Linux platform
  # elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
  #   # Do something under 32 bits Windows NT platform
  # elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
  #   # Do something under 64 bits Windows NT platform
  fi

  case $rom in
  AOSP)
    ls *.tgz | xargs -n1 tar -zxvf
    for i in extract*; do sed -n '/tail/p' $i | sed "s/\$0/$i/" | sh; done
    ;;
  esac

  perl -p -i -e "s/ro.secure=1/ro.secure=0/g" build/core/main.mk

  source build/envsetup.sh
  lunch aosp_$aosp_device-userdebug

  export LC_ALL=C

  set +e
  case $rom in
  AOSP)
    make -j$(nproc --all)
    while [ $? -ne 0 ]; do
      cd .
      make -j$(nproc --all)
    done
    ;;
  PixelExperience)
    croot
    mka bacon -j$(nproc --all)
    while [ $? -ne 0 ]; do
      cd .
      mka bacon -j$(nproc --all)
    done
    ;;
  *)
    echo "invalid rom $rom"
    exit 1
    ;;
  esac
  set -e

  perl -p -i -e "s/ == 0/ == -1/g" development/tools/mkstubs/src/com/android/mkstubs/FilterClassAdapter.java
  mmm development/tools/mkstubs/

  mmm development/tools/idegen/
  development/tools/idegen/idegen.sh

  cd ..
}

# aospDownload android-12.1.0_r11 redfin
# aospDownload android-11.0.0_r48 redfin
echo "parameter $@"
aospDownload "$@"
