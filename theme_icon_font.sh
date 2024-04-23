cd ~/
mkdir .themes
mkdir .icons
mkdir .fonts
# theme
cd ~/Downloads/
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
#cd ~/Downloads/WhiteSur-gtk-theme/release/
tar -xvf ~/Downloads/WhiteSur-gtk-theme/release/WhiteSur-Dark.tar.xz
mv -v ~/Downloads/WhiteSur-Dark/ ~/.themes
# icon
cd ~/Downloads/
git clone https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git
mv -v ~/Downloads/papirus-icon-theme/Papirus/ ~/.icons
# font
# font file has to be downloaded
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
