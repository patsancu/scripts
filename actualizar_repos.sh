#!/bin/bash

CONFIG_REPO=${HOME}/configs
PRIVATE_CONFIGS_REPO=${HOME}/privateconfigs
SCRIPTS_REPO=${HOME}/scripts
WIKI_REPO=${HOME}/wiki

echo ">>> Actualizando configs"
[ -d "$CONFIG_REPO" ] && cd ~/configs && git pull

echo ">>> Actualizando privateconfigs"
[ -d "$PRIVATE_CONFIGS_REPO" ] && cd ~/privateconfigs && git pull

echo ">>> Actualizando wiki"
[ -d "$WIKI_REPO" ] && cd ~/wiki && git pull

echo ">>> Actualizando scripts"
[ -d "$SCRIPTS_REPO" ] && cd ~/scripts && git pull
