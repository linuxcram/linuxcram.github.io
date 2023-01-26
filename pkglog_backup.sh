#!/bin/bash
# exit on command fail or use of unset variable
set -e
set -u
#
#
# This script checks the default package manager history log for AlmaLinux9 and Ubuntu22
# then set the archive names and create them suppressing any output 
#
# tar keeps the original files by default
# gzip removes the original files by default, gzip requires -k or -c options to keep the original files
#
#
# Function to create backup archive files for AlmaLinux9 - logfile named dnf.log
dnf_backup(){
  dnf_tar="dnf.log_$(date +%Y%m%d_%H%M%S).tar.gz"
  dnf_gz="dnf.log_$(date +%Y-%m-%d_%H-%M-%S).gz"
  tar czf $dnf_tar /var/log/dnf.log > /dev/null 2>&1
  gzip -9 -q -c /var/log/dnf.log > $dnf_gz
  echo -e "Backup files created:\n$dnf_tar\n$dnf_gz"
}
#
#
# Function to create backup archive files for Ubuntu22 - logfile named history.log
apt_backup(){
  apt_tar="history.log_$(date +%Y%m%d_%H%M%S).tar.gz"
  apt_gz="history.log_$(date +%Y-%m-%d_%H-%M-%S).gz"
  tar czf $apt_tar /var/log/apt/history.log > /dev/null 2>&1
  gzip -9 -q -c /var/log/apt/history.log > $apt_gz
  echo -e "Backup files created:\n$apt_tar\n$apt_gz"
}
#
#
# OS check and main section
#
# Clear the screen
clear
#
# Check if logfile is compliant to AlmaLinux9 OS and execute dnf function
if [ -f /var/log/dnf.log ]
then
  dnf_backup
  exit 0
#
# Check if logfile is compliant to Ubuntu22 OS and execute apt function
elif [ -f /var/log/apt/history.log ]
then
  apt_backup
  exit 0
#
# Check if logfile is not compliant to AlmaLinux9 or Ubuntu22 and print the error message
else
  echo -e "Error: OS not supported. Backup failed."
  exit 11
fi
