#!/bin/bash
# Exit on command fail
set -e
# Exit on use of unset variable
set -u
#
# Get the file and name it portslist.txt
# Credits to www.meridianoutpost.com
curl -Lks https://www.meridianoutpost.com/resources/articles/well-known-tcpip-ports.php -o portslist.txt
#
#
######## NOTES SECTION #########
# The following grep commmands should be used before preparing the script, and are shown for academic purpose.
# Grep is used to identify the lines of interest inside the file:
# the first and last lines containing a port number and its related information.
#
# command to find the first line, and its output
#grep -n "<td>0</td>" portslist.txt
#142:<td>0</td>
#
# command to find the last line, and its output
#grep -n -A4 "<td>995</td>" portslist.txt
#1193:<td>995</td>
#1194-<td>TCP</td>
#1195-<td>POP3 over SSL (encrypted transmission)</td>
#1196-<td>Official</td>
#1197-</tr>
##### END OF NOTES SECTION #####
#
#
# Extract the line of interest to a file named portstable.txt
head -n 1197 portslist.txt | tail -n +142 > portstable.txt
#
#
# Explanation:
# use sed command to replace any occurrence matching 
# <td> with nothing
# <\/td> with #
#
# use tr command to trim/replace wvery occurrence matcing
# \n with a space
# <tr> with /n
#
# replace using sed
# <\/tr> with \n
# <\/tr> with nothing
#  &nbsp; with -
# # with #
#
# use grep to exclude empty lines or lines starting with <
# that match the regex pattern "^$\|^<"
# 
# Generate the output file ports.csv then exit
sed 's/<td>//g' portstable.txt | sed 's/<\/td>/#/g' | tr -s '\n' ' ' | sed 's/<tr> /\n/g' | sed 's/ <\/tr>//g' | sed 's/ &nbsp;/-/g' | sed 's/# /#/g' | grep -v "^$\|^<" > ports.csv
#
exit 0
