#!/bin/bash

echo Actualizando Configs
cd ~/Configs && git pull
echo Actualizando privateconfigs
cd ~/privateconfigs && git pull
echo Actualizando wiki
cd ~/dev/wiki && git pull
