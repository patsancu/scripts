#!/usr/bin/env bash

BACKUP_REPO="$HOME/backups"

BACKUP_LOG_FOLDER=$HOME/tmp/backups/
mkdir -p $BACKUP_LOG_FOLDER


cd $BACKUP_REPO

#############
## Rhythmbox
#############
RHYTHMBOX_FILE=playlist_rhythmbox.xml
git diff --exit-code $RHYTHMBOX_FILE > /dev/null
if [ $? -eq 0 ]; then
    echo "$(date +'%Y%m%d-%H%M%S') Nothing new in rhythmbox" >> $BACKUP_LOG_FOLDER/logs.txt
else
    git add $RHYTHMBOX_FILE;
    git commit -m "rhythmbox $(date +'%Y%m%d-%H%M%S')";
    echo "$(date +'%Y%m%d-%H%M%S') A rhythmbox file was backed up" >> $BACKUP_LOG_FOLDER/logs.txt
fi


##################
## Music contents
##################
PATH_TO_MUSIC_FOLDER=/media/patrick/Toshiba/Música
MUSIC_CONTENTS_FILE=music_contents.txt
if [ -d $PATH_TO_MUSIC_FOLDER ]; then
    find $PATH_TO_MUSIC_FOLDER -not -path '*/\.*' -print | sed -e 's;/*/;|;g;s;|; |;g' > $MUSIC_CONTENTS_FILE
    git diff --exit-code $MUSIC_CONTENTS_FILE > /dev/null
    if [ $? -eq 0 ]; then
        echo "$(date +'%Y%m%d-%H%M%S') Nothing new in music" >> $BACKUP_LOG_FOLDER/logs.txt
    else
        git add $MUSIC_CONTENTS_FILE;
        git commit -m "music contents $(date +'%Y%m%d-%H%M%S')"
        echo "$(date +'%Y%m%d-%H%M%S') Music folder contents were backed up" >> $BACKUP_LOG_FOLDER/logs.txt
    fi
fi

git push >> $BACKUP_LOG_FOLDER/logs.txt

cd -
