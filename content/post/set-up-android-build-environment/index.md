---
title: Set up android build environment (Ubuntu 20.04)
description: Android build guide
slug: set-up-android-build-environment
date: 2022-06-03 00:00:00+3000
image: androidbuild.jpg
categories:
    - Android
tags:
    - Android
    - Build
---

- ⚠️ Note: I am using ubuntu 20.04. This manual is suitable for ubuntu 20.04, work on other OC/versions is unknown.
- There is actually an [official website](https://source.android.com/setup) where Google has explained this process in detail. I recommend visiting it. The instruction below is just a brief retelling of it with some additions from me.

## Installing & updating packages
### Updating already installed packages
- To begin with, we will update the existing packages in the system:
```bash
sudo apt-get update && sudo apt-get full-upgrade
```

### Installing packages for Android Build
- Now we will install the packages we need, which are not present by default in the system:
```bash
sudo apt-get install git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig bc ccache git imagemagick lib32readline-dev lib32z1-dev liblz4-tool pngquant libncurses5-dev libsdl1.2-dev libssl-dev libxml2 lzop pngcrush rsync schedtool squashfs-tools openjdk-8-jdk p7zip-full meld brotli qt5-qmake android-tools-adb android-tools-fastboot python3-networkx python3-pip texinfo maven swapspace m4
```

## Setting up packages
### CCache
- Let's set the ccache size. In the future, ccache will help you greatly speed up your build time. You can learn more about this technology [here](https://en.wikipedia.org/wiki/Cache_(computing)).
```bash
ccache -M 50G
```
- Now let's add the necessary variables for CCache to bashrc. They will be executed every time the terminal is opened.
```
echo "export USE_CCACHE=1" >> ~/.bashrc
```
### Use python3
- Making python 3 by default. Python 2 support was sunset on Jan 1, 2020. All major Linux distributions are deprecating support for the Python 2 package.

```bash
sudo ln -sf python3 /usr/bin/python
```

### Git
- Our computer doesn't know who I am in git. Let's help him solve this riddle by using this command.
```bash
git config --global user.name your_name && git config --global user.email email@example.com
```
- Don't forget to change these parameters to your own:
- your_name - Username, GitHub nickname
- email@example.com - GitHub account email


## Other settings
### LC_ALL
- LC_ALL is the environment variable that overrides all the other localisation settings. The C locale is a special locale that is meant to be the simplest locale. [More detailed](https://unix.stackexchange.com/questions/87745/what-does-lc-all-c-do/87763#87763)
```bash
echo "export LC_ALL=C" >> ~/.bashrc
```

## Downloading repo
- To sync the sources, we need a repo. Let's install it right from https://gerrit.googlesource.com/git-repo/.
```bash
cd $HOME && mkdir -p ~/.bin && PATH="${HOME}/.bin:${PATH}" && curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo && chmod a+rx ~/.bin/repo
```
- Well, now you can sync the repo.

### Download problems
- If the download is stuck at 99%, you can use this and re-sync
```bash
sudo sysctl -w net.ipv4.tcp_window_scaling=0
```
