#!/bin/bash

#nvutils
#flatpak install flathub com.leinardi.gwe
#nvdriver
sudo dnf install rpmfusion-nonfree-release-rawhide -y
sudo dnf --enablerepo=rpmfusion-nonfree-rawhide install akmod-nvidia-open xorg-x11-drv-nvidia xorg-x11-drv-nvidia-cuda xorg-x11-drv-nvidia-libs.i686 xorg-x11-drv-nvidia-cuda-libs.i686 --nogpgcheck 
#sudo dnf install gcc kernel-headers kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-power
#sudo dnf install xorg-x11-drv-nvidia-libs.i686
sudo cp nvidia-kms.conf /etc/modprobe.d/
