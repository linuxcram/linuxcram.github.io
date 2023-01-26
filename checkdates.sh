#!/bin/bash
# Exit on command fail
set -e
# Exit on use of unset variable
set -u
#
# Function to create random dates for naming the files
random_date(){
rnd_year=$(shuf -i 2000-2022 -n 1)
rnd_month_tmp=$(shuf -i 1-12 -n 1)
if [ $rnd_month_tmp -gt "9" ] 
then
  rnd_month="$rnd_month_tmp"
else
  rnd_month="0$rnd_month_tmp"
fi
month_last_day=$(cal $rnd_month_tmp $rnd_year | tail -n +3 | head -n +5 | tr '\n' ' ' | awk 'NF>1{print $NF}')
rnd_day_tmp=$(shuf -i 1-$month_last_day -n 1)
if [ $rnd_day_tmp -gt "9" ] 
then
  rnd_day="$rnd_day_tmp"
else
  rnd_day="0$rnd_day_tmp"
fi
echo "$rnd_year$rnd_month$rnd_day"
}
#
# Function to create the file and write the random generated string
create_day_files(){
  logdate=$(random_date)
  echo "$(< /dev/urandom tr -dc A-Z | head -c4)$(< /dev/urandom tr -dc a-z | head -c4)$(< /dev/urandom tr -dc 0-9 | head -c4)" > log_$logdate.log
}
#
check_weekday(){
filedates=$(ls -tr log_* | tr -d 'log_' | tr -d '.' | tr '\n' ' ')
for filedate in $filedates
do
  weekday=$(date -d $filedate | cut -d " " -f 1)
  
done
}
# Function to print the day of the week of the date in the name of the files
check_year(){
  case $weekday in Mon)  echo "log_$logdate.log - Monday";;
  Tue)  echo "log_$logdate.log - Tuesday";;
  Wed)  echo "log_$logdate.log - Wednesday";;
  Thu)  echo "log_$logdate.log - Thursday";;
  Fri)  echo "log_$logdate.log - Friday";;
  Sat)  echo "log_$logdate.log - Saturday";;
  Sun)  echo "log_$logdate.log - Sunday";;
  *) echo "log_$logdate.log - Error: Weekday not recognized";;
  esac
}
#
# Clean previous existing files if existing - Always use rm with caution in scripts
if [ $(find . -type f -name "log_*.log" | wc -l) -gt 1 ]
then
  rm -f log_*.log
fi
#
# For cycle to repeat the task 4 times
for new_files in {1..4}
do
  create_day_files
  check_weekday
  check_year
done
exit 0

