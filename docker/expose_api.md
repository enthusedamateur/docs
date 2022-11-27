Modify `/etc/default` to add / uncomment

    DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4 -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"

Then edit `/etc/init.d/docker` and `/etc/init/docker.conf` to include

    DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"

edit `/lib/systemd/system/docker.service` and modify
    
    ExecStart=/usr/bin/docker daemon -H fd:// -H tcp://0.0.0.0:

Then run the following command to reload your changes and restart the docker daemon.

`sudo systemctl daemon-reload && sudo systemctl restart docker.service`
