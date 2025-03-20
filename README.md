# Post Fedora Install Guide

## DNF config
- `sudo nano /etc/dnf/dnf.conf`
- Add:
```sh
# added for speed
fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True
```

## Default XOrg
```sh
# installing XOrg 
sudo dnf install gnome-session-xsession
sudo nano /etc/gdm/custom.conf
# uncomment this line:
WaylandEnable=false
# then add after:
DefaultSession=gnome-xorg.desktop
```

## Toggle grub menu to select kernel version
- show: `sudo grub2-editenv - unset menu_auto_hide`
- hide: `sudo grub2-editenv - set menu_auto_hide=1`

## Set hostname
`sudo hostnamectl set-hostname # and the hostname at the end`

## Update
```sh
sudo dnf upgrade --refresh
sudo reboot
```

## RPM Fusion
https://rpmfusion.org/Configuration

```sh
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=1
sudo dnf update @core
```

## NVIDIA
https://rpmfusion.org/Howto/NVIDIA

- disable Secure Boot
```sh
sudo dnf upgrade # and reboot if you are not on the latest kernel
sudo dnf install akmod-nvidia
sudo dnf install xorg-x11-drv-nvidia-cuda # optional for cuda/nvdec/nvenc support
```
- wait up to 5 minutes so akmod can build the driver
- once built, `modinfo -F version nvidia` returns the current driver version
- `sudo reboot`

This way, akmod will rebuild the driver after each kernel update. (Make sure to reboot after 5 minutes after every kernel update, so the building can be finished!)

## Media Codecs and Development Tools
https://rpmfusion.org/Howto/Multimedia

```sh
sudo dnf swap ffmpeg-free ffmpeg --allowerasing # switch to full ffmpeg
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf update @sound-and-video
sudo dnf install libva-nvidia-driver.{i686,x86_64} #hardware accelerated codec
```
To list the dnf development groups: `dnf group list --hidden \*devel\*`
```sh
sudo dnf install @c-development
sudo dnf install @development-tools
sudo dnf install cmake
```

## Connect to Internet
https://github.com/morrownr/8821au-20210708

This will install the driver and will add to dkms, which will rebuild the driver after every kernel update:
```sh
# make sure that you are on the latest kernel
sudo dnf install git dkms kernel-devel # dependencies
mkdir ~/Downloads/Installers/
cd ~/Downloads/Installers/
git clone https://github.com/morrownr/8821au-20210708.git
cd ~/Downloads/Installers/8821au-*
sudo ./install-driver.sh
sudo reboot
```

## Flatpak
```sh
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak update
```

## New Text Document
`cd Templates/ && touch "New Text Document.txt"`

## Mount secondary drive
- With the UUID from `lsblk -f`, insert into `/etc/fstab`: `UUID=youruuid /media/Data  ext4    defaults,nofail 0 0`
- `sudo reboot`
- Add ownership with: `sudo chown youruser:youruser /media/Data -R`
- For the drive to appear in Nautilus: Navigate to the drive in the filesystem -> Three dots in the search bar -> Add to bookmark.

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
```sh
cd ~/Downloads/Installers/
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
cd WhiteSur-gtk-theme/
./install.sh --help
```

- icon: Papirus - [gnome-look](https://www.gnome-look.org/p/1166289), [github](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/)
- font: SF Pro - [Apple](https://developer.apple.com/fonts/)
- terminal font: JetBrainsMono Nerd Font - [github](https://github.com/JetBrains/JetBrainsMono)

- install 7z beforehand: `sudo dnf install p7zip p7zip-plugins`
- use the `theme_icon_font.sh` script: `wget https://raw.githubusercontent.com/tsoby02/fedora-install-guide/refs/heads/main/theme_icon_font.sh`

## Add swapfile (WiP)
```sh
sudo btrfs subvolume create /var/swap
sudo btrfs filesystem mkswapfile --size ...g --uuid clear /var/swap/swapfile # replace with your ammount
sudo findmnt -no UUID -T /var/swap/swapfile
sudo btrfs inspect-internal map-swapfile -r /var/swap/swapfile
sudo grubby --args="resume=UUID=... resume_offset=..." --update-kernel=ALL # replace with your UUID and offset
sudo nano /etc/fstab
# add the following (setting the priority lower than zram's):
/var/swap/swapfile                        none                    swap    defaults,pri=0 0 0
sudo swapon /var/swap/swapfile
sudo reboot
swapon # to verify
```

## Installing apps
- Btrfs Assistant: [Guide](https://knowledgebase.frame.work/en_us/fedora-system-restore-root-snapshots-using-btrfs-assistant-rkHNxajS3)
- Wine: [Wine Dependency Hell](https://www.gloriouseggroll.tv/how-to-get-out-of-wine-dependency-hell/)
    - use `sudo dnf install wine --skip-unavailable` to skip a few unavailable packages
- ProtonUp-Qt: from Gnome Software (flathub)
- Mangohud: [github](https://github.com/flightlessmango/MangoHud?tab=readme-ov-file#installation---pre-packaged-binaries)
    - download Releases and, inside the folder, execute `./mangohud-setup.sh install`
    - `cd ~/.config/MangoHud/ && wget https://raw.githubusercontent.com/tsoby02/fedora-install-guide/refs/heads/main/MangoHud.conf`
- Steam: `sudo dnf install steam`
- CS2 launch options: `mangohud %command% -allow_third_party_software` 
- Lutris: `sudo dnf install lutris`
- Brave: https://brave.com/linux/
    - if it does not work: https://community.brave.com/t/cant-install-brave-on-linux-fedora-41/578115
    - [Privacy settings](https://www.privacyguides.org/en/desktop-browsers/#recommended-brave-configuration)
- Spotify: from Gnome Software (flathub)
- Discord: `sudo dnf install discord`
- VLC media player: `sudo dnf install vlc`
