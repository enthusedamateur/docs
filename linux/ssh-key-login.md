# SSH with Key

## Generate a new key

    cd ~/.ssh
<!-- -->
    ssh-keygen -b 4096 -f DEVICE.key

You'll be prompted to enter a password, you can leave this blank if you wish. 
You shouldn't, but you can. 

## Deploy the key

To deploy the new public key to the target device, use the following command. Replace DEVICE.key.pub with the name you entered in
the step above. Replace USER with the username on the target device. Replace DEVICE with the IP or Hostname of the target device.

    ssh-copy-id -i DEVICE.key.pub USER@DEVICE
    
    
  ### Windows PowerShell  
    type $env:USERPROFILE\.ssh\id_rsa.pub | ssh {IP-ADDRESS-OR-FQDN} "cat >> .ssh/authorized_keys"

Enter the password for the user account your're connecting with.
