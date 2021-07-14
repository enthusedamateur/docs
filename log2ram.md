git clone https://github.com/azlux/log2ram.git && cd log2ram && chmod +x install.sh && sudo ./install.sh && sudo nano /etc/log2ram.conf

#change ram folder size to 128M

sudo reboot

#check disk is mounted after reboot

df -h
