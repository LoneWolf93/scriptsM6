#! /bin/bash

mods_enabled=`ls $ruta/mods-enabled/|grep ".load"|cut -d "." -f1`
mods_available=`ls $ruta/mods-available/|grep ".load"|cut -d "." -f1`

# funcion para activar los modulos de apache
function activate_MOD () {
    local mod
    read -p "Que mod quieres activar? " mod
    
    local mods_enabled1=`ls $ruta/mods-enabled|grep $mod.load`
    
    if [ -z $mods_enabled1 ]; then
        echo "El mod $mod que quiere activar no esta en la lista de habilitados"
        echo "Activando..."
        #`cd $ruta/mods-available/`
        sleep 1
        sudo a2enmod $mod
        echo "Restarting apache2..."
        sleep 1
        `systemctl restart apache2`
    else
        echo "Este mod $mod no puede habilitarse porque ya lo esta"
    fi
}

# funcion para desactivar los modulos de apache
function deactivate_MOD () {
    local mod
    read -p "Que mod quieres desactivar? " mod
    
    local mods_enabled2=`ls $ruta/mods-enabled|grep $mod.load`
    
    if [ -z $mods_enabled2 ]; then
        echo "No se puede desactivar el modulo $mod porque no esta activado."
    else
        echo "Desactivando mod $mod"
        sudo a2dismod $mod
        `systemctl restart apache2`
        echo "MOD: $mod ha sido desactivado."
    fi
}

# funcion para listar los modulos de apache
function list_mods () {
    local i=0
    for file in $mods_available; do
        local existe=$(ls $ruta/mods-enabled|grep ".load"|grep "$file")
        
        if [ -z "$existe" ]; then
            echo -e "Linea $i: \e[91m$file\e[39m" #>> disabled.txt
        else
            echo -e "Linea $i: \e[92m$file\e[39m" #>> enabled.txt
        fi
        
        ((i++))
    done
}

