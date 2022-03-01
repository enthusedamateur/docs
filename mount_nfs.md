# Auto mounting NFS shares

## Installation
 
    sudo apt-get install rpcbind nfs-common

##### Important
Automount units must be named after the automount directories they control.

Example: the automount point /home/USER/mount/nas must be configured in a unit file home-USER-mount-nas.mount.

    mkdir /home/USER/mount/nas
<!-- -->
    showmount -e 192.168.1.?

Setup auto mount Systemd file

    sudo nano /etc/systemd/system/home-USER-mount-nas-DIRNAME.mount
<!-- -->
    [Unit]
    Description=NFS Directory

    [Mount]
    What=192.168.1.?:/nfs/RemoteNFSDirName
    Where=/nfs/nas/DIRNAME
    Type=nfs
    Options=rw,hard,intr,x-systemd.automount

    [Install]
    WantedBy=multi-user.target


#### Enable in Systemd
    sudo systemctl enable nfs-nas-DIRNAME.mount && sudo systemctl daemon-reload && sudo systemctl start nfs-nas-DIRNAME.mount && sudo systemctl status nfs-nas-DIRNAME.mount
