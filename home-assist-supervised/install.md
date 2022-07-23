The steps where as follows;
Update your OS with the following two commands:

sudo apt-get update && sudo apt-get upgrade

Install needed Home Assistant Supervised dependencies
sudo apt-get install network-manager apparmor-utils jq -y

Reboot
sudo reboot

Get the official docker script for Raspberry Pi
curl -fsSL https://get.docker.com​ -o get-docker.sh

Start the script
sudo sh get-docker.sh

Give Pi user needed permissions
sudo usermod -aG docker pi

Get the HA installer script
# No longer works
sudo curl -Lo installer.sh https://raw.githubusercontent.com/home-assistant/supervised-installer/master/installer.sh

#New link
wget https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb
dpkg -i homeassistant-supervised.deb


Start the HA installer script change the machine with any of these

https://github.com/home-assistant/supervised-installer#supported-machine-types

sudo bash installer.sh --machine raspberrypi4
