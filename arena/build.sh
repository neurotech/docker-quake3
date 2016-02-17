#!/bin/bash

# Variables
## Colours
### Modifiers
UL_ON=$(tput smul)
UL_OFF=$(tput rmul)
RESET=$(tput sgr0)

### Foreground
FG_BLACK=$(tput setaf 16)
FG_RED=$(tput setaf 1)
FG_GREEN=$(tput setaf 2)
FG_YELLOW=$(tput setaf 3)
FG_BLUE=$(tput setaf 4)
FG_MAGENTA=$(tput setaf 5)
FG_CYAN=$(tput setaf 6)
FG_WHITE=$(tput setaf 7)

### Background
BG_BLACK=$(tput setab 16)
BG_RED=$(tput setab 1)
BG_GREEN=$(tput setab 2)
BG_YELLOW=$(tput setab 3)
BG_BLUE=$(tput setab 4)
BG_MAGENTA=$(tput setab 5)
BG_CYAN=$(tput setab 6)
BG_WHITE=$(tput setab 7)

### Runes
RUNE_OK="${BG_GREEN}${FG_BLACK} > ${RESET}"
RUNE_WARN="${BG_YELLOW}${FG_BLACK} ~ ${RESET}"
RUNE_ERROR="${BG_RED}${FG_BLACK} ! ${RESET}"
RUNE_INFO="${BG_BLUE}${FG_BLACK} - ${RESET}"
RUNE_LINE="${BG_MAGENTA}${FG_BLACK} = ${RESET}"

cat << "EOF"
__________    _____  ________
\______   \  /  _  \ \_____  \
 |       _/ /  /_\  \  _(__  <
 |    |   \/    |    \/       \
 |____|_  /\____|__  /______  /
        \/         \/       \/

EOF
read -p "${FG_RED}Press [Enter] to begin.${RESET}"

clear

# --------
# Checking
# --------

## docker?
if hash docker 2>/dev/null; then
  echo "${RUNE_OK} `docker --version` is installed."
  echo
  sleep 0.5s
else
  echo "${RUNE_ERROR} docker is not installed! Exiting."
  sleep 0.5s
  exit 1
fi

## Environment variables?
### PAK0
if env | grep -q ^PAK0=
then
  echo "${RUNE_OK} ${FG_GREEN}PAK0 environment variable is set.${RESET}"
else
  tput bel
  echo "${RUNE_ERROR} ${FG_RED}PAK0 environment variable is not set! Exiting...${RESET}"
  sleep 0.5s
  exit 1
fi

### RA3
if env | grep -q ^RA3=
then
  echo "${RUNE_OK} ${FG_GREEN}RA3 environment variable is set.${RESET}"
else
  tput bel
  echo "${RUNE_ERROR} ${FG_RED}RA3 environment variable is not set! Exiting...${RESET}"
  sleep 0.5s
  exit 1
fi

### SERVERCFG
if env | grep -q ^SERVERCFG=
then
  echo "${RUNE_OK} ${FG_GREEN}SERVERCFG environment variable is set.${RESET}"
else
  tput bel
  echo "${RUNE_ERROR} ${FG_RED}SERVERCFG environment variable is not set! Exiting...${RESET}"
  sleep 0.5s
  exit 1
fi

### ARENACFG
if env | grep -q ^ARENACFG=
then
  echo "${RUNE_OK} ${FG_GREEN}ARENACFG environment variable is set.${RESET}"
  echo
else
  tput bel
  echo "${RUNE_ERROR} ${FG_RED}ARENACFG environment variable is not set! Exiting...${RESET}"
  sleep 0.5s
  exit 1
fi

# --------------
# Begin building
# --------------

## Base quake3
echo "${RUNE_INFO} Building base quake3 image from Dockerfile"
docker build -t quake .
echo "${RUNE_OK} ${FG_GREEN}Base quake3 image built${RESET}"
echo

## quake-data container
echo "${RUNE_INFO} Building and running quake-data container"
docker run -v /home/ioq3srv/.q3a/baseq3 -v /home/ioq3srv/.q3a/arena --name quake-data busybox
echo "${RUNE_OK} ${FG_GREEN}quake-data image built and container run${RESET}"
echo

### Copy pak0, RA3 files, server and arena .cfgs
echo "${RUNE_INFO} Copying pak0.pk3 to quake-data"
sleep 0.5s
docker cp ${PAK0} quake-data:/home/ioq3srv/.q3a/baseq3/
echo "${RUNE_OK} ${FG_GREEN}Copied${RESET}"
echo

echo "${RUNE_INFO} Copying RA3 mod files to quake-data"
sleep 0.5s
docker cp ${RA3} quake-data:/home/ioq3srv/.q3a/
echo "${RUNE_OK} ${FG_GREEN}Copied${RESET}"
echo

echo "${RUNE_INFO} Copying server.cfg to quake-data"
sleep 0.5s
docker cp ${SERVERCFG} quake-data:/home/ioq3srv/.q3a/arena/server.cfg
echo "${RUNE_OK} ${FG_GREEN}Copied${RESET}"
echo

echo "${RUNE_INFO} Copying arena.cfg to quake-data"
sleep 0.5s
docker cp ${ARENACFG} quake-data:/home/ioq3srv/.q3a/arena/arena.cfg
echo "${RUNE_OK} ${FG_GREEN}Copied${RESET}"
echo

echo
echo "${RUNE_OK} ${FG_GREEN}Bootstrapping complete!${RESET}"
echo
tput bel
