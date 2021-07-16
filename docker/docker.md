# Installing Docker & Docker Compose

## Docker-ce

    curl -sSL https://get.docker.com | sh

## Docker-compose

First we need to install python and some dependencies.

    sudo apt-get install libffi-dev libssl-dev
\

    sudo apt install python3-dev
\

    sudo apt-get install -y python3 python3-pip

Now we can install docker-compose

    sudo pip3 install docker-compose

# Enable docker to run on boot

    sudo systemctl enable docker


## Sample docker-compose.yml

    version: '3'
    services:
      # Tests the current internet connection speed
      # once per hour and writes the results into an
      # InfluxDB instance
      speedtest:    
        image: robinmanuelthiel/speedtest:0.1.1
        restart: always
        depends_on:
          - influxdb
        environment:
          - LOOP=true
          - LOOP_DELAY=3600 # Once per hour
          - DB_SAVE=true
          - DB_HOST=http://influxdb:8086
          - DB_NAME=speedtest
          - DB_USERNAME=admin
          - DB_PASSWORD=<MY_PASSWORD>
    
      # Creates an InfluxDB instance to store the
      # speed test results
      influxdb:
        image: influxdb
        restart: always
        volumes:
          - influxdb:/var/lib/influxdb
        ports:
          - "8083:8083"
         - "8086:8086"
        environment:
          - INFLUXDB_ADMIN_USER=admin
          - INFLUXDB_ADMIN_PASSWORD=<MY_PASSWORD>
          - INFLUXDB_DB=speedtest
    
      # Displays the results in a Grafana dashborad
      grafana:
    image: grafana/grafana:latest
        restart: always
        depends_on:
          - influxdb
        ports:
          - 3000:3000
        volumes:
          - grafana:/var/lib/grafana
    
    volumes:
      grafana:
      influxdb:


### Link

https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script

    curl -fsSL https://get.docker.com -o get-docker.sh && sudo sh get-docker.sh
