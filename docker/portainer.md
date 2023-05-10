# Installing Portainer

## Portainer

    https://documentation.portainer.io/v2.0/deploy/ceinstalldocker/
    
!
    
    docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce


Enable TCP port 2375 for external connection to Docker
------------------------------------------------------

See this [issue](https://github.com/moby/moby/issues/25471).  
Docker best practise to [Control and configure Docker with systemd](https://docs.docker.com/engine/admin/systemd/#/custom-docker-daemon-options).  

1. Create `daemon.json` file in `/etc/docker`:

        {"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}

2. Add `/etc/systemd/system/docker.service.d/override.conf`

        [Service]
        ExecStart=
        ExecStart=/usr/bin/dockerd


3. Reload the systemd daemon:

        systemctl daemon-reload

4. Restart docker:

        systemctl restart docker.service
