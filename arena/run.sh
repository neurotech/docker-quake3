#!/bin/bash
RESET=$(tput sgr0)
FG_BLUE=$(tput setaf 4)

echo "${FG_BLUE} Running 'quake' container using volumes from 'quake-data':${RESET}"
sleep 0.5s
docker run --name quake -d -p 0.0.0.0:27960:27960/udp --volumes-from quake-data quake +set fs_game arena +set vm_game 0 +set sv_pure 1 +set bot_enable 0 +set sv_punkbuster 0 +set dedicated 2 +set net_port 27960 +exec server.cfg
