#!/bin/bash
# Script to print the Fibonacci sequence
#
# Exit on error 
set -e
#
# Number of values to display, argument accepted for numeriv values >0
# if no argument is given, the default length of sequence is set to 10
if ! [[ $1 -gt 0 ]]
then
  end_value=10
else
  end_value=$1
fi
#
# First number of Fibonacci sequence (0)
first_value=0
#
# Second number of Fibonacci sequence (1)
second_value=1
echo -e "The Fibonacci sequence of $end_value numbers is: "
# For loop - count controlled counter
for (( i=0; i<$end_value; i++ ))
do
  echo -e "$first_value"
  seq_value=$((first_value + second_value))
  first_value=$second_value
  second_value=$seq_value
done
exit 0
