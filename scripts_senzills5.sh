#!/bin/bash
echo "[1] Veure detalls d'un arxiu o directori"
echo "[2] Crear un arxiu"
echo "[3] Eliminar arxiu"
echo "[4] Canviar el nom de l'arxiu"
echo "[5] Sortir"

read menu


case $menu in
	1)
		echo "Que archivo o fichero quieres ver?"
		read archivo
		ls -l $archivo
		;;
	2)
		echo "Escribe el nombre del archivo para crearlo"
		read archivo
		touch $archivo
		echo "El archivo $archivo ha sido creado"
		;;
	3)
		echo "Escribe el nombre del fichero a borrar"
		read archivo
		if [ -e $archivo ]
		then
			rm -rf $archivo
			echo "El archivo $archivo ha sido eliminado"
		else
			echo "El archivo $archivo no existe"
		fi
		;;
	4)
		echo "Escribe el nombre del archivo para modificar su nombre"
		read archivo
		if [ -e $archivo ]
		then
			read archivo_modificado
			mv $archivo $archivo_modificado
			echo "El fichero $archivo ha cambiado su nombre por $archivo_modificado"
		else
			echo "El archivo $archivo no existe"
		fi
		;;
	5)
		echo "Bye!"
		exit
esac
