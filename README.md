# Post Fedora Install Guide

## DNF config
- `sudo nano /etc/dnf/dnf.cong`
- Add:
```sh
#added for speed
fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True
```

## Default XOrg
```sh
sudo nano /etc/gdm/custom.conf
# uncomment, and then add: DefaultSession=gnome-xorg.desktop
```

## Toggle grub menu to select kernel version
- show: `sudo grub2-editenv - unset menu_auto_hide`
- hide: `sudo grub2-editenv - set menu_auto_hide=1`

## RPM Fusion
- https://rpmfusion.org/Configuration
- `sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`
- `sudo dnf config-manager --enable fedora-cisco-openh264`
- `sudo dnf groupupdate core`

## Update
- `sudo dnf update`
- `sudo dnf upgrade --refresh`
- `sudo reboot`

## Connect to Internet
https://github.com/aircrack-ng/rtl8812au
This has to be done with every kernel update, dkms seems to not be working properly:
```sh
sudo dnf install kernel-devel # needs the kernel headers
git clone -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git
cd rtl*
sudo make && make install
```

## NVIDIA
- https://rpmfusion.org/Howto/NVIDIA
- disable Secure Boot
```sh
sudo dnf upgrade # and reboot if you are not on the latest kernel
sudo dnf install akmod-nvidia
sudo dnf install xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support
```
- wait 5 minutes
- once built, `modinfo -F version nvidia` return the current driver version
- `sudo reboot`

## Media Codecs
- https://rpmfusion.org/Howto/Multimedia
- switch to full ffmpeg: `sudo dnf swap ffmpeg-free ffmpeg --allowerasing`
- `sudo dnf groupupdate multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin`
- `sudo dnf groupupdate sound-and-video`
- hardware accelerated codec: `sudo dnf install nvidia-vaapi-driver`

## Flatpak
- `flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo`
- `flatpak update`

## Set hostname
- `sudo hostnamectl set-hostname`
- `sudo reboot`

## New Text Document
```sh
cd Templates/
touch "New Text Document.txt"
```

## Gnome

### Extensions
- `sudo dnf install gnome-tweaks`
- `sudo dnf install gnome-extensions-app`
- `flatpak install com.mattjakeman.ExtensionManager`
- Extensions:
```
AppIndicator and KStatusNotifierItem Support
Dash to Dock
Extension List
[QSTweak] Quick Setting Tweaker
spotify-tray
User Themes
Window title is back
```

### Theme, icons, font
- create .themes, .fonts, .icons folders in /home
- theme: WhiteSur - [gnome-look](https://www.gnome-look.org/p/1403328), [github](https://github.com/vinceliuice/WhiteSur-gtk-theme) (To change the activities icon on the left side of the top bar, modify the `Whitesur/Whitesur-Dark/gnome-shell/assets/activities.svg file's content.)
- icon: Papirus - [gnome-look](https://www.gnome-look.org/p/1166289), [github](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/)
- font: SF Pro - [Apple](https://developer.apple.com/fonts/)
```sh
7z x SF-Pro.dmg
cd SFProFonts/
7z x "SF Pro Fonts.pkg"
7z x Payload~
cd Library
mv Fonts/ SF\ Pro/ # rename
# then move "SF Pro" to .icons
```

Or alternatively use the `theme_icon_font.sh` script.

## Install apps
- Mangohud: [github](https://github.com/flightlessmango/MangoHud?tab=readme-ov-file#installation---pre-packaged-binaries) - download Releases, in folder execute `./mangohud-setup.sh install`, then copy `MangoHud.conf` into `~/.config/MangoHud`
- Wine: [Wine Dependency Hell](https://www.gloriouseggroll.tv/how-to-get-out-of-wine-dependency-hell/)
- ProtonUp-Qt: from Gnome Software (flathub)
- Steam: `sudo dnf install steam`
- CS2 launch options: `mangohud %command% -allow_third_party_software` 
- Lutris: `sudo dnf install lutris`
- Brave: https://brave.com/linux/
```sh
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser
```
- Spotify: from Gnome Software (flathub)
- JetBrains
