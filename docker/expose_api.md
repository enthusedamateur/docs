I modified /etc/default to add / uncomment DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4 -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"

I also modified /etc/init.d/docker and /etc/init/docker.conf to include DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock".

edit /lib/systemd/system/docker.service

sudo systemctl daemon-reload
sudo systemctl restart docker.service
