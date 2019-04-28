#! /bin/bash
error_found=false
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
        echo "$i" >> prueba.log
        error_found=true
    fi
done

if [ "$error_found" = "true" ]; then
    echo "Hay un error en el servicio apache2, revisa el log de apache" | mail -s "Error log apache" albert.esparrell@gmail.com
fi