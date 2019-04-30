#! /bin/bash

function monitorUse () {
    # Tanto por ciento de la partición en home
    porcentaje=$(df -h --type=ext4 --output='pcent' --output='target' | grep "/media" | cut -d " " -f2 | sed 's/.$//')
    
    # ejercicio 2.1.2 --> ls -l /home/* --sort=size | grep ^- | head -n1
    
    # Comprobamos si el porcentaje de la particion /home supera o es igual al 15%
    if [ $porcentaje -ge 15 ]; then
        echo "Borrando papelera"
        # Borramos todo el contenido de la papelera
        $(rm -r /media/albert/f71fef67-1d8a-4f93-9012-94f8f8d327b3/.Trash-1000/files/* 2>/dev/null)
    fi
    
    papelera=$(ls -A /media/albert/f71fef67-1d8a-4f93-9012-94f8f8d327b3/.Trash-1000/files/)
    
    # Si el porcentaje de la particion montada sigue siendo mas grande de 15% y la papelera esta vacía
    # Movemos los archivos de mas tamaño
    if [ $porcentaje -ge 15 ]; then
        if [ -z $papelera ]; then
            archivo_no_oculto=$(ls -l /home/* --sort=size | grep ^- | head -n1 | awk '{ printf $9 }' | grep ^. | cut -c 1)
            if [ $archivo_no_oculto != . ]; then
                usuario_del_fichero=$(ls -l /home/* --sort=size | grep ^- | head -n1 | awk '{ print $3 }')
                if [ $usuario_del_fichero != "root" ]; then
                    echo "Moviendo los archivos de mas tamaño"
                    archivo=$(ls -l /home/* --sort=size | grep ^- | head -n1 | awk '{ print $9 }')
                    $(cd /home/albert)
                    $(mv /home/albert/$archivo /media/albert/f71fef67-1d8a-4f93-9012-94f8f8d327b3/$archivo)
                fi
                
            fi
            
        fi
    fi
    
    
    
    
}
monitorUse

