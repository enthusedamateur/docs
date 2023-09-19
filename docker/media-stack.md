# Name the file docker-compose.yml

version: "3.9"
name: media-stack
services:
  vpn:
    ## Read https://github.com/qdm12/gluetun/wiki for details on configuring VPN for different service providers.
    container_name: vpn
    image: qmcgaw/gluetun:v3.32
    cap_add:
      - NET_ADMIN
    environment:
      - VPN_SERVICE_PROVIDER=protonvpn # Valid values: nordvpn, expressvpn, protonvpn, surfshark or custom
      - VPN_TYPE=openvpn
      - OPENVPN_USER=oCJQjeXBTwg_CHsdbdqb.SdO
      - OPENVPN_PASSWORD=7j+qsTnwhnehGMhMM91pfYe6
      ## SERVER_COUNTRIES is required for ExpressVPN and ProtonVPN. Comment SERVER_REGIONS if SERVER_COUNTRIES is used.
      - SERVER_COUNTRIES=${SERVER_COUNTRIES:-United Kingdom}
    networks:
      - media-network
    ports:
      # qbittorrent ports
      - 5080:5080
      - 6881:6881
      - 6881:6881/udp
      # prowlarr ports
      - 9696:9696
      # radarr ports
      - 7878:7878
      # sonarr ports
      - 8989:8989
      # bazarr ports
      - 6767:6767
      # Transmission ports. Uncomment below if Transmission is used with VPN
      # - 9091:9091
      # - 51413:51413
      # - 51413:51413/udp
    deploy:
      resources:
        limits:
          cpus: '0.2'  # Maximum of 0.5 CPU cores
          memory: 512M  # Maximum of 512 megabytes of RAM
        #reservations:
        #  cpus: '0.2'  # Minimum of 0.2 CPU cores
        #  memory: 256M  # Minimum of 256 megabytes of RAM
    restart: "unless-stopped"

  qbittorrent:
    container_name: qbittorrent
    image: linuxserver/qbittorrent:4.5.2
    # Comment this if vpn is disabled
    depends_on:
      - vpn
    #networks:
    #  - media-network
    network_mode: service:vpn # Comment this line if vpn is disabled
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=UTC
      - WEBUI_PORT=5080
    volumes:
      - qbittorrent-config:/config
      - torrent-downloads:/downloads
      - media-stack_media:/mnt/media
    deploy:
      resources:
        limits:
          cpus: '0.2'  # Maximum of 0.5 CPU cores
          memory: 512M  # Maximum of 512 megabytes of RAM
        #reservations:
        #  cpus: '0.2'  # Minimum of 0.2 CPU cores
        #  memory: 256M  # Minimum of 256 megabytes of RAM        
    ## Uncomment below ports if VPN is disabled.
    # ports:
    #   - 5080:5080
    #   - 6881:6881
    #   - 6881:6881/udp
    restart: "unless-stopped"

  radarr:
    container_name: radarr
    image: linuxserver/radarr:latest
    network_mode: service:vpn
    #networks:
    #  - media-network
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=UTC
    ## Uncomment below ports if VPN is disabled.
    #ports:
    #  - 7878:7878
    volumes:
      - radarr-config:/config
      - torrent-downloads:/downloads
      - media-stack_media:/mnt/media
    deploy:
      resources:
        limits:
          cpus: '0.1'  # Maximum of 0.5 CPU cores
          memory: 256M  # Maximum of 512 megabytes of RAM
        #reservations:
        #  cpus: '0.2'  # Minimum of 0.2 CPU cores
        #  memory: 256M  # Minimum of 256 megabytes of RAM
    restart: "unless-stopped"

  sonarr:
    image: linuxserver/sonarr:4.0.0-develop
    container_name: sonarr
    network_mode: service:vpn
    #networks:
    #  - media-network
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=UTC
    volumes:
      - sonarr-config:/config
      - torrent-downloads:/downloads
      - media-stack_media:/mnt/media
    ## Uncomment below ports if VPN is disabled.
    #ports:
    #  - 8989:8989
    deploy:
      resources:
        limits:
          cpus: '0.1'  # Maximum of 0.5 CPU cores
          memory: 256M  # Maximum of 512 megabytes of RAM
        #reservations:
        #  cpus: '0.2'  # Minimum of 0.2 CPU cores
        #  memory: 256M  # Minimum of 256 megabytes of RAM
    restart: unless-stopped

  prowlarr:
    container_name: prowlarr
    image: linuxserver/prowlarr:1.3.1-develop
    # Comment this if vpn is disabled
    depends_on:
      - vpn
    network_mode: service:vpn # Comment this line if vpn is disabled
    #networks:
    #  - media-network
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=UTC
    volumes:
      - prowlarr-config:/config
      - media-stack_media:/mnt/media
    ## Uncomment below ports if VPN is disabled.
    # ports:
    #   - 9696:9696
    deploy:
      resources:
        limits:
          cpus: '0.1'  # Maximum of 0.5 CPU cores
          memory: 256M  # Maximum of 512 megabytes of RAM
        #reservations:
        #  cpus: '0.2'  # Minimum of 0.2 CPU cores
        #  memory: 256M  # Minimum of 256 megabytes of RAM
    restart: unless-stopped
  bazarr:
    image: linuxserver/bazarr:latest
    container_name: bazarr
    network_mode: service:vpn
    #networks:
    #  - media-network
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=UTC
    volumes:
      - bazarr-config:/config
      - media-stack_media:/mnt/media
    ## Uncomment below ports if VPN is disabled.
    #ports:
    #  - 6767:6767
    deploy:
      resources:
        limits:
          cpus: '0.1'  # Maximum of 0.5 CPU cores
          memory: 256M  # Maximum of 512 megabytes of RAM
        #reservations:
        #  cpus: '0.2'  # Minimum of 0.2 CPU cores
        #  memory: 256M  # Minimum of 256 megabytes of RAM
    restart: unless-stopped
volumes:
  torrent-downloads:
  bazarr-config:
  radarr-config:
  sonarr-config:
  prowlarr-config:
  qbittorrent-config:
  tx-config:
  tx-watch:
  media-stack_media:
    external: true
    name: media-stack_media

networks:
  media-network:
    external: true
