# check if font file is downloaded to ~/Downloads/
if [ ! -f ~/Downloads/SF-Pro.dmg ]
then
	echo "ERROR: SF-Pro.dmg is not downloaded to the Downloads folder. Download it before proceeding!"
	exit 1
fi

cd ~/
mkdir .themes
mkdir .icons
mkdir .fonts

# theme
cd ~/Downloads/
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
tar -xvf ~/Downloads/WhiteSur-gtk-theme/release/WhiteSur-Dark.tar.xz
mv -v ~/Downloads/WhiteSur-Dark/ ~/.themes

# icon
cd ~/Downloads/
git clone https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git
mv -v ~/Downloads/papirus-icon-theme/Papirus/ ~/.icons

# font
cd ~/Downloads/
7z x SF-Pro.dmg
cd SFProFonts/
7z x "SF Pro Fonts.pkg"
7z x Payload~
cd Library
mv Fonts/ SF\ Pro/ # rename
mv "SF Pro" ~/.fonts

# delete resources
cd ~/Downloads/
rm -fv SF-Pro.dmg
rm -rfv SFProFonts/
rm -rfv WhiteSur-gtk-theme/
rm -rfv papirus-icon-theme/
