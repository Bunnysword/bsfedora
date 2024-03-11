#!/bin/bash

#FOR_GNOME_F38+
#configuration dnf
echo -e "\tconfiguration dnf" && sudo sh -c "echo -e 'fastestmirror=True\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True' >> /etc/dnf/dnf.conf"
sudo dnf autoremove && sudo dnf clean all && sudo dnf in dnf-automatic && systemctl enable dnf-automatic.timer
#rpmfusion
echo -e "\trpmfusion" && sudo dnf in https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf in rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data
#rm_stok_apps
echo -e "\trm stock apps" && sudo dnf rm mediawriter rhythmbox evince yelp gnome-characters gnome-logs totem gnome-tour gnome-photos gnome-maps gnome-weather gnome-font-viewer gnome-contacts gnome-clocks gnome-calendar gnome-boxes firefox libreoffice* power-profiles-daemon
#codecs
echo -e "\tcodecs" && sudo dnf in gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf in lame\* --exclude=lame-devel && sudo dnf group upgrade Multimedia --with-optional --allowerasing
#Kernel_Fsync
echo -e "\tKernel Fsync" && sudo dnf copr enable sentry/kernel-fsync -y
sudo grubby --args="gpu_sched.sched_policy=0" --update-kernel=ALL
#NoiseTorch
echo -e "\tNoiseTorch" && sudo dnf copr enable principis/NoiseTorch -y
#Discord
echo -e "\tDiscord" && sudo dnf config-manager --add-repo https://terra.fyralabs.com/terra.repo
echo -e "\tmutter patch" && sudo dnf copr enable trixieua/mutter-patched -y
#Install_Apps
echo -e "\tInstall Apps" && sudo dnf in mangohud timeshift goverlay steam lutris transmission-gtk kdenlive vlc gnome-tweaks htop redhat-lsb-core rocm-opencl inxi neofetch protontricks openssl discord noisetorch easyeffects corectrl gimp google-chrome-stable openrgb piper --allowerasing
sudo dnf update --refresh
#Flatpak
echo -e "\tFlatpak" && flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak install flathub com.heroicgameslauncher.hgl com.obsproject.Studio com.mattjakeman.ExtensionManager
#Disable_Services
echo -e "\tOFF_Services" && sudo systemctl mask plymouth-quit-wait.service
systemctl disable dmraid-activation.service
systemctl disable livesys-late.service
systemctl disable livesys.service
systemctl disable rpcbind.service
systemctl disable lvm2-monitor.service
systemctl disable NetworkManager-wait-online.service
#Papirus_icon
echo -e "\tPapirus icons"
sudo dnf in papirus-icon-theme
#corectrl
sudo cp 90-corectrl.rules /etc/polkit-1/rules.d/
#Fix_Volume_Step_for_Fifine_H6
echo -e "Fix_Volume_Step_for_Fifine H6"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-step 9
#Fix_Suspend_for_Gigabyte_Aorus_Elite_v2_B550
echo -e "Fix Suspend for Gigabyte Aorus Elite v2 B550"
sudo cp wakeup-disable_GPP0.service /etc/systemd/system/
sudo systemctl enable wakeup-disable_GPP0.service && sudo systemctl start wakeup-disable_GPP0.service
#Fix_rgb_logitech_g213
mkdir /home/bunnysword/.config/OpenRGB && cp 1.orp /home/bunnysword/.config/OpenRGB/
#mkdir -p /home/bunnysword/.config/systemd/user/ && cp openrgb.service /home/bunnysword/.config/systemd/user/ && systemctl --user enable --now openrgb.service
#other
neofetch && cp config.conf /home/bunnysword/.config/neofetch/ && neofetch
