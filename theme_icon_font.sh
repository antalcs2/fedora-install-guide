# downloading and installing the JetBrainsMono Nerd Font
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

# installing the San Francisco Pro font from Apple
cd ~/Downloads/
wget https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg

# check if font file is downloaded to ~/Downloads/
if [ ! -f ~/Downloads/SF-Pro.dmg ]
then
	echo "ERROR: SF-Pro.dmg is not downloaded to the Downloads folder!"
	exit 1
fi

# create folders
cd ~/
mkdir .themes
mkdir .icons
mkdir .fonts

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
rm -rfv papirus-icon-theme/
