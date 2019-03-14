#!/bin/bash

#Importamos el archivo .sh de las funciones
source functions.sh

flag=true

# Lee el nombre del servicio introducido
read -p "Introduce el nombre del servicio: " service_name

# Muestra el estado del servicio
status="service $service_name status"

# Muestra el estado actual del servicio
current_status=`$status|grep "active"|cut -d " " -f5`

while $flag; do
# Condicion para mostrar el menu
if [ "$current_status" = "active" ]; then
showMenuRunning $current_status $service_name
else
showMenuStopped $current_status
fi
done

#echo $current_status