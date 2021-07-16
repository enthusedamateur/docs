# Add new user
    sudo adduser USER
<!-- -->
    sudo usermod -aG sudo USER

Test your account in a new session, then delete the old account.

    sudo su USER
<!-- -->
    sudo deluser PI


## Add Sudo
    usermod -aG sudo username

### Passwordless Sudo

Edit sudoers file:

    sudo nano /etc/sudoers

add this line, changing USER as appropriate:

    USER ALL=(ALL) NOPASSWD: ALL

Save changes.
