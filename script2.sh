#! /bin/bash


function monitorUse () {
    # Tanto por ciento de la partición en uso
    porcentaje=$(df -h --type=ext4 --output='pcent' | sed 's/.$//')
    # Directorio donde está montado la partición
    particiones=$(df -h --type=ext4 --output='target')
    
    array_porcentajes=($porcentaje)
    #echo ${array_porcentajes[1]}
    array_particiones=($particiones)
    
    longitud_porcentajes=${#array_porcentajes[@]}
    longitud_particiones=${#array_particiones[@]}


    
    
    
    
}
monitorUse

