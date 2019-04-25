#! /bin/bash

function timelog () {
    IFS=$'\n'
    data=`LC_ALL=en_EN.utf8 date`
    data15m=`LC_ALL=en_EN.utf8 date --date '-1 min'`
    #echo $data
    #echo $data15m
    data_ini=$(date -d "$data15m" +%s)
    #echo $data_ini
    i=$1
    for i in `grep 'error' /var/log/apache2/error.log`; do
        data_log=`echo $i | cut -d " " -f 1-4 | cut -c2-`
        dlog=$(date -d "$data_log" +%s)
        #echo $dlog
        if [ $dlog -ge $data_ini ]; then
            echo "$i"
        fi
    done
}

# Funcion para visualizar el estado del servicio
function checkService () {
    status_apache2=$(systemctl status apache2 | grep "active" | cut -d " " -f 5)
    
    if [ "$status_apache2" != "active" ]; then
        echo "El servicio esta parado, avisando al administrador" | mail -s "Peligro servicio parado" albert.esparrell@gmail.com
        for (( intentos=0; intentos<=4; intentos++ )); do
            status_apache2=$(systemctl status apache2 | grep "active" | cut -d " " -f 5)
            $(systemctl restart apache2 --no-ask-password)
        done
        if [ "$status_apache2" = "active" ]; then
            echo "El servicio esta activo, todo Ok" | mail -s "Servicio activo" albert.esparrell@gmail.com
        fi
    fi

prueba=""
    
    hola=`timelog $prueba`

    echo $hola
    
    
}
checkService
#timelog