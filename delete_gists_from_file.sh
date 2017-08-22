#!/usr/bin/env bash

if [ $# -eq 1 ]; then
    input="$1"
    echo File being parsed is $input
    while IFS= read -r gist_id
    do
      echo "Deleting gist: $gist_id"
      curl -X DELETE -H "Authorization: token $GITHUB_GIST_TOKEN" https://api.github.com/gists/$gist_id
    done < "$input"
else
    echo "Usage:"
    echo "  $0 file_with_gist_ids"
    echo
    echo "----------"
    echo
    echo "Notes:"
    echo "  * the file should contain one gist id per line"
    echo -n "  * This script "
    which tput > /dev/null && tput setab 1
    echo -n "does not"
    which tput > /dev/null && tput setab clear
    echo " give any feedback if it succeeds"
    echo "    If it fails, the curl command will forward you github's gist api error message"
fi
