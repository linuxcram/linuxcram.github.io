#!/bin/bash
# exit on error or undefined variable
set -o errexit
set -o nounset
#
# Variables
urls_list="url_checker_list.txt"
#
# Function that prints URL and first line of html code without tags, reading URLs from list file url_checker_list.txt
pages_list_check(){
  for url in $(cat url_checker_list.txt | tr '\n' ' ')
  do
    curl_result=$(curl -kLs "$url" | grep -e "<title>" | head -1 | sed 's/<title>//g' | sed 's/<\/title>//g')
    echo -e "$url $curl_result"
  done
}
# Conditional cycle to exit on missing input file url_checker_list.txt or perform operations
if ! [ -s $urls_list ]
then
  echo -e "Error: pages list file not found or file is empty."
  exit 11
else
  pages_list_check
  exit 0
fi
