#! /bin/bash

IFS=$'\n'
data=`LC_ALL=en_EN.utf8 date`
data15m=`LC_ALL=en_EN.utf8 date --date '-15 min'`
echo $data
echo $data15m
data_ini=$(date -d "$data15m" +%s)
echo $data_ini
for i in `grep 'error' /var/log/apache2/error.log`; do
    data_log=`echo $i | cut -d " " -f 1-4 | cut -c2-`
    dlog=$(date -d "$data_log" +%s)
    #echo $dlog
    if [ $dlog -ge $data_ini ]; then
        echo "$i"
    fi
done