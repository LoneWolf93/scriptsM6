#! /bin/bash

function monitorUse () {
    # Tanto por ciento de la partición en home
    porcentaje_dir_home=$(df -h --type=ext4 --output='pcent' --output='target' | grep "/media" | cut -d " " -f2 | sed 's/.$//')

    fecha=$(date +"%d-%m-%Y")
    hora=$(date +"%H:%M:%S")
    
    particion_superada=false
    
    # Bucle para mirar todas las particiones del sistema con el sistema de archivos ext4
    for porciento in $(df -h --type=ext4 --output='pcent' | sed 's/.$//'); do
        if [ $porciento -ge 15 ]; then
            #echo "Alguna particion ha superado el limite del 15%"
            particion_superada=true
        fi
    done
    
    # Si hay alguna particion que ha superado el limite del 15% enviamos un correo al administrador
    if [ "$particion_superada" = "true" ]; then
        echo "Alguna particion ha superado el limite del 15%" | mail -s "Una o mas particiones ha superado el limite" albert.esparrell@gmail.com
    fi
    
    # Comprobamos si el porcentaje_dir_home de la particion /home supera o es igual al 15%
    if [ $porcentaje_dir_home -ge 15 ]; then
        #echo "Borrando papelera"
        # Borramos todo el contenido de la papelera
        $(rm -r /media/albert/f71fef67-1d8a-4f93-9012-94f8f8d327b3/.Trash-1000/files/* 2>/dev/null)
    fi
    
    papelera=$(ls -A /media/albert/f71fef67-1d8a-4f93-9012-94f8f8d327b3/.Trash-1000/files/)
    
    # Si el porcentaje_dir_home de la particion montada sigue siendo mas grande de 15% y la papelera esta vacía
    # Movemos los archivos de mas tamaño
    if [ $porcentaje_dir_home -ge 15 ]; then
        if [ -z $papelera ]; then
            archivo_no_oculto=$(ls -l /home/* --sort=size | grep ^- | head -n1 | awk '{ printf $9 }' | grep ^. | cut -c 1)
            if [ $archivo_no_oculto != . ]; then
                usuario_del_fichero=$(ls -l /home/* --sort=size | grep ^- | head -n1 | awk '{ print $3 }')
                if [ $usuario_del_fichero != "root" ]; then
                    #echo "Moviendo los archivos de mas tamaño"
                    archivo=$(ls -l /home/* --sort=size | grep ^- | head -n1 | awk '{ print $9 }')
                    echo "El dia $fecha a las $hora el archivo $archivo con más tamaño ha sido enviado a la partición /media/albert/f71fef67-1d8a-4f93-9012-94f8f8d327b3/" >> informe2.log
                    $(cd /home/albert)
                    $(mv /home/albert/$archivo /media/albert/f71fef67-1d8a-4f93-9012-94f8f8d327b3/$archivo)
                    
                fi
                
            fi
            
        fi
    fi
    
    
    
    
}
monitorUse

