#!/bin/bash

echo "Introduce una interfaz de red"
read inet

flag=0

for files in `ls /etc/network/`; do

	ext=`grep "$inet" /etc/network/$files 2>/dev/null | cut -d " " -f2`

	if [ $ext ]; then
	echo "Si"
	flag=1
	filename=$files
	fi
done


if [ $flag -eq 1 ]; then
echo -e "El fichero es \e[100m$filename\e[49m"
else
echo "No se ha podido encontrar nada"
fi