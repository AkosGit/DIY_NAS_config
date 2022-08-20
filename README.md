# Open Source DIY NAS config

- The config uses docker compose with 6 projects.
- The reused variables are stored in the .env_base file, but some needs to be changed in the yml files.
- All the configurations are stored in one directory defined in the B_PATH variable.
- A little bit of script that will bring the projects up and can be used to update the projects.
```bash                                                                   
#/bin/bash
arr=( "auth" "media" "monitor" "networking" "torrent" "files")
for item in "${arr[@]}"
do
    docker-compose -f $item/$item.yml --env-file .env_base pull
    docker-compose -f $item/$item.yml --env-file .env_base up -d --remove-orphans
    yes | docker image prune
done
```
## Projects
#### Auth
- vaultwarden: cross platform password manager
#### Files
- filebrowser: simple way to view files on your drives, with full controll over files and a user managment system.
- syncthing: sync files between devices
- vsftpd: ftp server
#### Media
- tvheadend: IP tv and can be used with dvb tv cards
- jellyfin: media server with lots of clients, can be used with tv shows, movies, and even music
- navidrome: music server, with a nice pwa, and its compatible with subsonic api and clients
- photoprism: diy google photos, with face detection, search by location and much more
- audiobookshelf: audio drama, audiobook and podcast server
#### Monitor
- crontab-ui: view and edit crontab tasks in web ui
- portainer-ce: docker container manager
- uptime-kuma: check services, sites if they are up or not. Also you can recive notfications from diferent sources.
- netdata: monitor system resources real-time in a nice web ui
#### Networking
- ddns-updater: update domains ip address
- caddy: web server, i use it fro reverse proxy to handle my domain and ssl
- wg-easy: wireguard container, with easy setup and web mangemt interface
#### Torrent
- sonarr: 
- radarr:
- bazarr:
- prowlarr:
- qbittorrent
