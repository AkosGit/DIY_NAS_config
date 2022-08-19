# DIY NAS config

- The config uses docker compose with 6 projects.
- The reused variables are stored in the .env_base file, but some needs to be changed in the yml files.
- All the configurations are stored in one directory defined in the B_PATH variable.
- A litle bit of script that will bring the projects up and can be used to update the projects.
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
