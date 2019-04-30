#! /bin/bash


function monitorUse () {
    # Tanto por ciento de la partición en home
    porcentaje=$(df -h --type=ext4 --output='pcent' --output='target' | grep "/media" | cut -d " " -f2 | sed 's/.$//')
    # Directorio donde está montado la partición
    particiones=$(df -h --type=ext4 --output='target')
    
    array_porcentajes=($porcentaje)
    #echo ${array_porcentajes[1]}
    array_particiones=($particiones)
    
    longitud_porcentajes=${#array_porcentajes[@]}
    longitud_particiones=${#array_particiones[@]}
    
    # ejercicio 2.1.2 --> ls -l /home/* --sort=size | grep ^- | head -n1
    
    if [ $porcentaje -ge 15 ]; then
        echo "Borrando papelera"
        # Borramos todo el contenido de la carpeta
        $(rm -r /media/albert/f71fef67-1d8a-4f93-9012-94f8f8d327b3/.Trash-1000/files/* 2>/dev/null)
    fi
    
    papelera=$(ls -A /media/albert/f71fef67-1d8a-4f93-9012-94f8f8d327b3/.Trash-1000/files/)
    
    # Si el porcentaje de la particion montada sigue siendo mas grande de 15% y la papelera esta vacía
    # Movemos los archivos de mas tamaño
    if [ $porcentaje -ge 15 ]; then
        if [ -z $papelera ]; then
            echo "Moviendo los archivos de mas tamaño"
            $(ls -l /home/* --sort=size | grep ^- | head -n1)
        fi
    fi
    
    
    
    
}
monitorUse

