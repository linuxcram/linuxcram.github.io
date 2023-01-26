#!/bin/bash
#
# Welcome script that uses happy colorful text/background
#
# exit on command fail
set -e
string="\n >\n ->\n -->\n\n\tWelcome to Linux.\n\n\tLet's learn Bash scripting.\n\n -->\n ->\n >"
clear
echo -en "\e[5m\e[34m\e[42m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
echo
for i in $string
  do
  #echo -n "$i "
  echo -e "\e[1m\e[32m\e[44m$i \e[0m\c"
  sleep 0.3
done
echo
echo
echo -e "\e[5m\e[34m\e[42m>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\e[0m"
echo
exit 0
