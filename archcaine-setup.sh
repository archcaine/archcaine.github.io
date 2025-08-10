sudo pacman -S wget
sudo wget https://colaciane.github.io/ARCH-CAINE/archcaine-setup.sh
archcaine-setup.sh
echo Thank you for using ARCH-CAINE :)
sudo pacman -Syu
echo You will need to do Y/N for packages, don't say yes to all, a lot are optional applications you may not want!
echo Essential ArchCaine packages are going to be installed regardless, and you won't need to answer yes or no :)
sudo pacman -S nano 
echo Plasma is a popular desktop interface, highly customizable and is highly recommended to use!
echo Plasma, while recommended, is not essential, so you will be able to do y/n
sudo pacman -S plasma
echo 'apt' package is not recommended for Arch Linux unless you know how to PROPERLY set it up.
sudo pacman -S apt
sudo pacman -S kitty 
sudo pacman -S power-profiles-daemon 
# sudo wget https://colacaine.github.io/archcaine/archcaine/misc.zip
sudo pacman -S zip 
sudo pacman -Scommand:github.copilot.chat.startCopilotDebugCommand unzip 
sudo pacman -S nautilus
echo npm is recommended
sudo pacman -S npm
sudo pacman -R archcaine-setup.sh
// if didn't already
exit