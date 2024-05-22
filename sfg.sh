#!/bin/bash

#FOR_GNOME_F39+ by Bunny Sword
#configuration dnf
sudo sh -c "echo -e 'fastestmirror=True\nmax_parallel_downloads=10\ndefaultyes=True\nkeepcache=True' >> /etc/dnf/dnf.conf"
sudo dnf autoremove -y && sudo dnf clean all && sudo dnf in -y dnf-automatic && systemctl enable dnf-automatic.timer
#rpmfusion
sudo dnf in -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf in -y rpmfusion-free-appstream-data rpmfusion-nonfree-appstream-data
#rm_stok_apps
sudo dnf rm -y mediawriter rhythmbox evince yelp gnome-characters gnome-logs gnome-tour gnome-photos gnome-maps gnome-weather gnome-font-viewer gnome-contacts gnome-clocks gnome-calendar gnome-boxes libreoffice* power-profiles-daemon
# totem firefox
sudo dnf in -y gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel #Codec
sudo dnf in -y lame\* --exclude=lame-devel && sudo dnf group upgrade -y Multimedia --with-optional --allowerasing
sudo dnf copr enable -y sentry/kernel-fsync #Fsync
sudo dnf copr enable -y principis/NoiseTorch && sudo dnf in -y noisetorch #Noisetorch
sudo dnf config-manager --add-repo https://terra.fyralabs.com/terra.repo && sudo dnf in -y discord #Discord from Terra
#GNOME tips
sudo dnf in -y papirus-icon-theme #Papirus icons
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-step 1
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
sudo dnf copr enable -y trixieua/mutter-patched #Mutter patched
#Install_Apps
sudo dnf in -y mangohud timeshift goverlay steam lutris transmission-gtk kdenlive vlc gnome-tweaks htop redhat-lsb-core rocm-opencl inxi neofetch protontricks openssl discord noisetorch easyeffects gimp openrgb piper nvtop google-chrome-stable --allowerasing
#corectrl
sudo dnf update -y --refresh #Update
#Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak install flathub -y com.heroicgameslauncher.hgl com.obsproject.Studio com.mattjakeman.ExtensionManager net.davidotek.pupgui2 portproton
#Services
sudo systemctl mask plymouth-quit-wait.service && systemctl disable livesys-late.service && systemctl disable livesys.service && systemctl disable rpcbind.service && systemctl disable lvm2-monitor.service && systemctl disable NetworkManager-wait-online.service #Disable
sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/tcp && sudo firewall-cmd --zone=public --permanent --add-port=1714-1764/udp && sudo systemctl restart firewalld.service #GSconnect fix
sudo mv /services/wakeup-disable_GPP0.service /etc/systemd/system/ && sudo systemctl enable wakeup-disable_GPP0.service && sudo systemctl start wakeup-disable_GPP0.service #B550 fix
mv services/noisetorch.service /home/bunnysword/.config/systemd/user/
systemctl --user daemon-reload && systemctl --user start noisetorch && systemctl --user enable noisetorch
#Other
mkdir /home/bunnysword/.config/OpenRGB && mv conf/1.orp /home/bunnysword/.config/OpenRGB/ #OpenRGB profile
mkdir /home/bunnysword/.config/neofetch && mv conf/config.conf /home/bunnysword/.config/neofetch/ && neofetch #Neofetch conf
mkdir /home/bunnysword/.config/MangoHud && mv conf/MangoHud.conf /home/bunnysword/.config/MangoHud/ #MangoHud
git clone https://github.com/JustTemmie/steam-presence && mv conf/config.json steam-presence/ && cd steam-presence/ && ./installer.sh && cd ..
#NVIDIAMOMENTO
cd nvdriver/ && chmod 750 nvdriver.sh && ./nvdriver.sh && inxi -G
####sudo grubby --args="gpu_sched.sched_policy=0" --update-kernel=ALL for amd wayland fix
####sudo mv conf/90-corectrl.rules /etc/polkit-1/rules.d/ #Corectrl rules for amd
####sudo mv conf/environment /etc && sudo dmesg | grep BAR= #BAR for amd
