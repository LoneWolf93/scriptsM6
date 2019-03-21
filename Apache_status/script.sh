#!/bin/bash

#Importamos el archivo .sh de las funciones
source functions.sh

flag=true
exists=true
# Lee el nombre del servicio introducido
read -p "Introduce el nombre del servicio: " service_name

services=(`systemctl list-unit-files|cut -d " " -f1| grep ".service"`)

# Contador para recorrer el array de los servicios
i=0
# Recorremos un array que estan todos los servicios del sistema
while [ $i -lt ${#services[@]} ]; do
    # Condicion de si el servicio existe en el sistema
    if [ "$service_name.service" = ${services[$i]} ]; then
        #echo ${services[$i]} "EXISTE!!"
        while $flag; do
            # Muestra el estado del servicio
            status="systemctl status $service_name"
            # Muestra si esta activado o desactivado
            current_status=`$status|grep "active"|cut -d " " -f5`
            
            # Condicion para mostrar el menu
            if [ "$current_status" = "active" ]; then
                showMenuRunning $current_status $service_name
                elif [ "$current_status" = "inactive" ]; then
                showMenuStopped $current_status $service_name
            fi
        done
        
    else
        exists=false
    fi
    #echo ${services[$i]}
    ((i++))
done

if [ "$exists" = "false" ]; then
    echo $service_name "no existe"
    #prueba
fi


#echo $current_status