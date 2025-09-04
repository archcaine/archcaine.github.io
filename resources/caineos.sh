sudo pacman -S wget
sudo wget https://colaciane.github.io/archcaine/archcaine/archcaine-setup.s
archcaine-setup.sh
echo Thank you for using ARCH-CAINE :)
sudo pacman -Syu
echo "You will need to do Y/N for packages, don't say yes to all, a lot are optional applications you may not want!"
echo "You will be told if something is an essential package."
sudo pacman -S nano 
echo "Plasma is a popular desktop interface, highly customizable and is highly recommended to use!"
echo "Plasma, while recommended, is not essential."
sudo pacman -S plasma
echo "'apt' package is not recommended for Arch Linux unless you know how to PROPERLY set it up."
sudo pacman -S apt
sudo pacman -S kitty 
sudo pacman -S power-profiles-daemon 
# sudo wget https://colacaine.github.io/archcaine/archcaine/misc.zip
sudo pacman -S zip 
sudo pacman -S unzip 
sudo pacman -S nautilus
echo npm is recommended
sudo pacman -S npm
sudo pacman -R archaine-setup.sh 
// if didn't already
exit
