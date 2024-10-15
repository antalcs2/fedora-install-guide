# Post Fedora Install Guide
```sh
git clone https://github.com/tsoby02/fedora-install-guide
```

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

## Update
- `sudo dnf upgrade --refresh`
- `sudo reboot`

## RPM Fusion
- https://rpmfusion.org/Configuration
- `sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm`
- `sudo dnf config-manager --enable fedora-cisco-openh264`
- `sudo dnf update @core`

## Connect to Internet
https://github.com/morrownr/8821au-20210708
This will install the driver and will add to dkms, which will rebuild the driver after every kernel update:
```sh
sudo dnf update
sudo reboot
sudo dnf install git dkms kernel-devel # dependencies
cd ~/Downloads/
git clone https://github.com/morrownr/8821au-20210708.git
cd ~/Downloads/8821au-*
sudo ./install-driver.sh
sudo reboot
```

## NVIDIA
- https://rpmfusion.org/Howto/NVIDIA
- disable Secure Boot
```sh
sudo dnf upgrade # and reboot if you are not on the latest kernel
sudo dnf install akmod-nvidia
sudo dnf install xorg-x11-drv-nvidia-cuda # optional for cuda/nvdec/nvenc support
```
- wait 5 minutes
- once built, `modinfo -F version nvidia` returns the current driver version
- `sudo reboot`

This way, akmod will rebuild the driver after each kernel update. (Make sure to reboot after 5 minutes when the kernel is updated, so the building can be finished!)

## Media Codecs
- https://rpmfusion.org/Howto/Multimedia
- switch to full ffmpeg: `sudo dnf swap ffmpeg-free ffmpeg --allowerasing`
- `sudo dnf groupupdate multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin`
- `sudo dnf update @sound-and-video`
- hardware accelerated codec: `sudo dnf install libva-nvidia-driver.{i686,x86_64}`

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

## Mount secondary drive
- With the UUID from `lsblk -f`, insert into `/etc/fstab`:
`UUID=youruuid /media/Data  ext4    defaults,nofail 0 0`
- Add ownership with:
`sudo chown youruser:youruser /media/Data -R`
- For the drive to appear in Nautilus: `Other locations` -> Click on the drive -> Three dots in the search bar -> Add to bookmark.

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
Weeks Start on Monday Again...
Window title is back
```

### Theme, icons, font
- theme: WhiteSur - [gnome-look](https://www.gnome-look.org/p/1403328), [github](https://github.com/vinceliuice/WhiteSur-gtk-theme) (To change the activities icon on the left side of the top bar, modify the `Whitesur/Whitesur-Dark/gnome-shell/assets/activities.svg file's content.)
- icon: Papirus - [gnome-look](https://www.gnome-look.org/p/1166289), [github](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/)
- font: SF Pro - [Apple](https://developer.apple.com/fonts/)
- terminal font: JetBrainsMono Nerd Font - [github](https://github.com/JetBrains/JetBrainsMono)

- install 7z beforehand: `sudo dnf install p7zip p7zip-plugins`
- use the `theme_icon_font.sh` script: `/bin/bash -c "$(wget https://raw.githubusercontent.com/tsoby02/fedora-install-guide/refs/heads/main/theme_icon_font.sh)"`

## Installing apps
- Btrfs Assistant: [Guide](https://knowledgebase.frame.work/en_us/fedora-system-restore-root-snapshots-using-btrfs-assistant-rkHNxajS3)
- Wine: [Wine Dependency Hell](https://www.gloriouseggroll.tv/how-to-get-out-of-wine-dependency-hell/)
- ProtonUp-Qt: from Gnome Software (flathub)
- Mangohud: [github](https://github.com/flightlessmango/MangoHud?tab=readme-ov-file#installation---pre-packaged-binaries)
    - download Releases and, inside the folder, execute `./mangohud-setup.sh install`
    - `cd ~/.config/MangoHud/ && wget https://raw.githubusercontent.com/tsoby02/fedora-install-guide/refs/heads/main/MangoHud.conf`
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
- Discord: `sudo dnf install discord`
- VLC media player: `sudo dnf install vlc`
