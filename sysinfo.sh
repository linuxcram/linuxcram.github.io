#!/bin/bash
# Exit on command fail
set -e
# Exit on use of unset variable
set -u
#
# Set the start time
start=$(date +%s.%N)
#
# Conditional loop to run the script only if executed in the home directory of the current user
# otherwise display a message and exit with exit code 11
if ! [ $(pwd) = $HOME ]
then
  echo -e "Error: this script can be run only in the current user home directory. Exiting."
  exit 11
else
# Define the logfile name
logfile=sysinfo_$(date +"%Y%m%d_%H%M%S").log
#
# Create the 5 files in the homedir
touch ./testfile{1..5}
#
# Create the directory structure
mkdir -p ./systems/{test,dev,prod}/sys/{01..03}
mkdir -p ./systems/{test,dev,prod}/srv/{04..06}
mkdir -p ./systems/{dev,prod}/app/{10,12,15}
#
# Copy the required files to the paths defined in the request using for loops
#
for x in {1..3}
do
  cp ./testfile$x ./systems/test/sys/0$x/
  cp ./testfile$x ./systems/dev/sys/0$x/
  cp ./testfile$x ./systems/prod/sys/0$x/
done
#
for y in {4,5}
do
  cp ./testfile$y ./systems/test/srv/0$y/
  cp ./testfile$y ./systems/dev/srv/0$y/
  cp ./testfile$y ./systems/prod/srv/0$y/
done
#
# Create 6 new files in their paths and and write their contents using output redirection and for loop
for z in {10,12,15}
do
  echo -e "id: $z" > ./systems/dev/app/$z/id.txt
  echo -e "id: $z" > ./systems/prod/app/$z/id.txt
done
#
# Write in the logfile the information required, including text, variables and command outputs
echo -e "#####" >> $logfile
echo -e "$(date +"%Y-%m-%d_%H:%M:%S")" >> $logfile
echo -e "Hostname: $(hostname)" >> $logfile
echo -e "Operating System: $(hostnamectl | grep "Operating System" | cut -d ":" -f 2)" >> $logfile
echo -e "IP address: $(ip a | grep "inet" | grep "wlp5s0" | awk '{print $2}' | cut -d'/' -f1)" >> $logfile
echo -e "Free Memory: $(free -h | grep Mem | awk '{print $4}')" >> $logfile
#
# Calculate and write the script run time into the logfile
duration=$(echo "$(date +%s.%N) - $start" | bc)
execution_time=$(printf "%.2f seconds" $duration)
echo -e "Run time: $execution_time" >> $logfile
echo -e "#####" >> $logfile
fi
#
# Delete the 5 files in the homedir, thate have been previously copied to the paths
rm -f ./testfile{1..5}
#
# Display a message showing the logfile name and exit script
echo -e "Script executed successfully. Logfile is: $logfile"
exit 0

