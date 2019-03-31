#!/bin/bash

CONFIG_FOLDER_PATH=~/configs
PRIVATE_FOLDER_PATH=~/privateconfigs
WIKI_FOLDER_PATH=~/wiki
SCRIPTS_FOLDER_PATH=~/scripts

echo ">>> Actualizando Configs"
cd $CONFIG_FOLDER_PATH && git pull
echo ">>> Actualizando privateconfigs"
cd $PRIVATE_FOLDER_PATH && git pull
echo ">>> Actualizando wiki"
cd $WIKI_PATH && git pull
echo ">>> Actualizando scripts"
cd $SCRIPTS_FOLDER_PATH && git pull
