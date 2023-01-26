#!/bin/bash
# exit on error or undefined variable
set -o errexit
set -o nounset
#
# Variables
urls_list="url_checker_list.txt"
#
# Conditional cycle to exit on missing input file, or perform operations reading URLs from list file
if ! [ -s $urls_list ]
then
  echo -e "Error: pages list file not found or file is empty."
  exit 11
else
  for url in $(cat url_checker_list.txt | tr '\n' ' ')
  do
    curl_result=$(curl -kLs "$url" | grep -e "<title>" | head -1 | sed 's/<title>//g' | sed 's/<\/title>//g')
    echo -e "$url $curl_result"
  done
  exit 0
fi
