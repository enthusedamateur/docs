# Add new user
    sudo adduser USER
    sudo usermod -aG sudo USER

Test your account in a new session, then delete the old account.

    sudo su USER
    sudo deluser PI


## Add Sudo
    usermod -aG sudo username

### Passwordless Sudo
1.  Edit sudoers file:
    sudo nano /etc/sudoers
2.  add:
    USER ALL=(ALL) NOPASSWD: ALL
where USER is your passwordless sudo username
Save your changes.
