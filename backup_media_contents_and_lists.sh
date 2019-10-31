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

track_contents_of_folder_and_back_it_up(){
    # First argument would be the folder
    # Second argument should be the name of the file where the contents will be dumped
    PATH_TO_FOLDER=$1
    CONTENTS_FILE=$2
    NAME_OF_TYPE_OF_DATA_TO_BE_SAVED=$3
    echo "Tracking $NAME_OF_TYPE_OF_DATA_TO_BE_SAVED"
    if [ -d "$PATH_TO_FOLDER" ]; then
        find "$PATH_TO_FOLDER" -not -path '*/\.*' -print | sed -e 's;/*/;|;g;s;|; |;g' > $CONTENTS_FILE
        git diff --exit-code $CONTENTS_FILE > /dev/null
        if [ $? -eq 0 ]; then
            echo "$(date +'%Y%m%d-%H%M%S') Nothing new in $NAME_OF_TYPE_OF_DATA_TO_BE_SAVED" >> $BACKUP_LOG_FOLDER/logs.txt
        else
            git add $CONTENTS_FILE;
            git commit -m "$NAME_OF_TYPE_OF_DATA_TO_BE_SAVED contents $(date +'%Y%m%d-%H%M%S')"
            echo "$(date +'%Y%m%d-%H%M%S') $NAME_OF_TYPE_OF_DATA_TO_BE_SAVED folder contents were backed up" >> $BACKUP_LOG_FOLDER/logs.txt
        fi
    fi
}

##################
## Music contents
##################

PATH_TO_MUSIC_FOLDER=/media/patrick/Toshiba/Música
MUSIC_CONTENTS_FILE=music_contents.txt
track_contents_of_folder_and_back_it_up "$PATH_TO_MUSIC_FOLDER" "$MUSIC_CONTENTS_FILE" "music"

##################
## IT Ebooks
##################
IT_EBOOKS_FOLDER="/media/patrick/Toshiba/IT ebooks"
IT_EBOOKS_CONTENT=it_ebooks_content.txt
track_contents_of_folder_and_back_it_up "$IT_EBOOKS_FOLDER" "$IT_EBOOKS_CONTENT" "it ebooks"

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
