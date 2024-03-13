#!/bin/bash

#FOR_GNOME_F39+ by Bunny Sword///////////////////////////
#configuration dnf///////////////////////////
sudo sh -c "echo -e 'fastestmirror=True\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True' >> /etc/dnf/dnf.conf" && sudo dnf autoremove && sudo dnf clean all && sudo dnf in dnf-automatic && systemctl enable dnf-automatic.timer
#rpmfusion//////////////////////////////
sudo dnf in https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf in rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data
#rm_stok_apps//////////////////////
sudo dnf rm mediawriter rhythmbox evince yelp gnome-characters gnome-logs totem gnome-tour gnome-photos gnome-maps gnome-weather gnome-font-viewer gnome-contacts gnome-clocks gnome-calendar gnome-boxes firefox libreoffice* power-profiles-daemon
#other///////////////////////
echo -e "\tcodecs" && sudo dnf in gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf in lame\* --exclude=lame-devel && sudo dnf group upgrade Multimedia --with-optional --allowerasing
echo -e "\tKernel Fsync" && sudo dnf copr enable sentry/kernel-fsync -y
sudo grubby --args="gpu_sched.sched_policy=0" --update-kernel=ALL
echo -e "\tNoiseTorch" && sudo dnf copr enable principis/NoiseTorch -y
echo -e "\tDiscord" && sudo dnf config-manager --add-repo https://terra.fyralabs.com/terra.repo
echo -e "\tMutter Patch" && sudo dnf copr enable trixieua/mutter-patched -y
#Install_Apps//////////
sudo dnf in mangohud timeshift goverlay steam lutris transmission-gtk kdenlive vlc gnome-tweaks htop redhat-lsb-core rocm-opencl inxi neofetch protontricks openssl discord noisetorch easyeffects corectrl gimp google-chrome-stable openrgb piper --allowerasing
#Update////////////
sudo dnf update --refresh
#Flatpak///////
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak install flathub com.heroicgameslauncher.hgl com.obsproject.Studio com.mattjakeman.ExtensionManager net.davidotek.pupgui2
#Disable_Services//
sudo systemctl mask plymouth-quit-wait.service && systemctl disable livesys-late.service && systemctl disable livesys.service && systemctl disable rpcbind.service && systemctl disable lvm2-monitor.service && systemctl disable NetworkManager-wait-online.service
#GSConnect//////
sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/tcp && sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/udp && sudo systemctl restart firewalld.service
#Fix Suspend for Gigabyte B550///////
sudo cp wakeup-disable_GPP0.service /etc/systemd/system/ && sudo systemctl enable wakeup-disable_GPP0.service && sudo systemctl start wakeup-disable_GPP0.service
#Corectrl Rules/////////
sudo cp 90-corectrl.rules /etc/polkit-1/rules.d/
#Fix_Volume_Step_3//////
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-step 3
#Fix_rgb_profile/////
mkdir /home/bunnysword/.config/OpenRGB && cp 1.orp /home/bunnysword/.config/OpenRGB/
#mkdir -p /home/bunnysword/.config/systemd/user/ && cp openrgb.service /home/bunnysword/.config/systemd/user/ && systemctl --user enable --now openrgb.service ?????????????????????
#other///////////
neofetch && cp config.conf /home/bunnysword/.config/neofetch/ && neofetch && sudo dnf in papirus-icon-theme
