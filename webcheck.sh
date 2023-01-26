#!/bin/bash
# Exit on command fail
set -e
# Exit on use of unset variable
set -u
#
# Set the start time
time_start=$(date +%Y-%m-%d_%H-%M-%S)
#
# Define the logfile
logfile="webcheck_$(date +%Y%m%d_%H%M%S).log"
#
# Define the hosts to build the URLs
hosts="garr.it google.com"
#
# Define the port to build the URLs0
port="80"
#
# Display a custom progress message
echo "Script running, please wait..."
#
# Write entries to the logfile
echo "--------------------------" >> $logfile  2>&1
echo "START: $time_start" >> $logfile 2>&1
#
# For cycle to perform curl on URLs and write data and output to logfile
# host is the name of the variable, hosts is the name of the list
for host in $hosts
do
    echo "">> $logfile  2>&1
    echo "URL: $host:$port" >> $logfile  2>&1
    curl -LIs $host:$port | grep "HTTP" | tail -1 >> $logfile  2>&1
    # wait 1 second after every curl command
    sleep 1
    echo "">> $logfile  2>&1
done
#
# set and write end time to logfile
time_end=$(date +%Y-%m-%d_%H-%M-%S)
#
echo "END:  $time_end" >> $logfile
echo "--------------------------" >> $logfile  2>&1
#
# Display a message showing the logfile name and exit script
echo -e "Script executed successfully. Logfile is: $logfile"
exit 0
