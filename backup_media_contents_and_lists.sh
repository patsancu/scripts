#!/usr/bin/env bash

BACKUP_REPO="$HOME/backups"

BACKUP_LOG_FOLDER=$HOME/tmp/backups/
mkdir -p $BACKUP_LOG_FOLDER


cd $BACKUP_REPO

#############
## Rhythmbox
#############
RHYTHMBOX_FILE=/home/patrick/.local/share/rhythmbox/playlists.xml
LOCAL_RHYTHMBOX_FILE=./playlist_rhythmbox.xml
diff $RHYTHMBOX_FILE $LOCAL_RHYTHMBOX_FILE > /dev/null
if [ $? -eq 0 ]; then
    echo "$(date +'%Y%m%d-%H%M%S') Nothing new in rhythmbox" >> $BACKUP_LOG_FOLDER/logs.txt
else
    cp -f $RHYTHMBOX_FILE $LOCAL_RHYTHMBOX_FILE
    git add $LOCAL_RHYTHMBOX_FILE;
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


##################
## IT Ebooks
##################
IT_EBOOKS_FOLDER="/media/patrick/Toshiba/IT ebooks"
IT_EBOOKS_CONTENT=it_ebooks_content.txt

if [ -d "$IT_EBOOKS_FOLDER" ]; then
    find "$IT_EBOOKS_FOLDER" -not -path '*/\.*' -print | sed -e 's;/*/;|;g;s;|; |;g' > $IT_EBOOKS_CONTENT
    git diff --exit-code $IT_EBOOKS_CONTENT > /dev/null
    if [ $? -eq 0 ]; then
        echo "$(date +'%Y%m%d-%H%M%S') Nothing new in it ebooks" >> $BACKUP_LOG_FOLDER/logs.txt
    else
        git add $IT_EBOOKS_CONTENT;
        git commit -m "it ebooks contents $(date +'%Y%m%d-%H%M%S')"
        echo "$(date +'%Y%m%d-%H%M%S') It ebooks folder contents were backed up" >> $BACKUP_LOG_FOLDER/logs.txt
    fi
fi

cd -
