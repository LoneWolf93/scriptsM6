#!/bin/bash

#Importamos el archivo .sh de las funciones
source ./Apache_status/functions.sh
flag=true
# Condicion de si el servicio existe en el sistema
while [ "$flag" = "true" ]; do
    # Muestra el estado del servicio
    status="systemctl status apache2"
    # Muestra si esta activado o desactivado
    current_status=`$status|grep "active"|cut -d " " -f5`
    # Condicion para mostrar el menu
    if [ "$current_status" = "active" ]; then
        showMenuRunning $current_status "apache2"
        elif [ "$current_status" = "inactive" ]; then
        showMenuStopped $current_status "apache2"
    fi
done
