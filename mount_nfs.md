# Auto mounting NFS shares

## Installation
 
    sudo apt-get install rpcbind nfs-common

##### Important
Automount units must be named after the automount directories they control.

Example: the automount point /mnt/remoteshare must be configured in a unit file mnt-remoteshare.mount.

    mkdir /mnt/remoteshare
<!-- -->
    showmount -e 192.168.1.?

Setup auto mount Systemd file

    sudo nano /etc/systemd/system/mnt-remoteshare.mount
<!-- -->
    [Unit]
    Description=NFS Directory

    [Mount]
    What=192.168.1.?:/remotehost/directory
    Where=/mnt/remoteshare
    Type=nfs
    Options=rw,hard,intr,x-systemd.automount

    [Install]
    WantedBy=multi-user.target


#### Enable in Systemd
    sudo systemctl enable mnt-remoteshare.mount
<!-- -->
    sudo systemctl daemon-reload
<!-- -->
    sudo systemctl start mnt-remoteshare.mount
<!-- -->
    sudo systemctl status mnt-remoteshare.mount
