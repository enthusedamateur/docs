type $env:USERPROFILE\\.ssh\id_rsa.pub | ssh {[email protected]} "cat >> .ssh/authorized_keys"
