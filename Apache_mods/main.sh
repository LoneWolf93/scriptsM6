#!/bin/bash

mods_enabled=`ls /etc/apache2/mods-enabled/|grep ".load"|cut -d "." -f1  2>/dev/null`
mods_available=`ls /etc/apache2/mods-available/|grep ".load"|cut -d "." -f1  2>/dev/null`

function menu () {
    echo -e "[1] Llistar moduls"
    echo -e "[2] Activat modul"
    echo -e "[3] Desactivar modul"
    echo -e "[S] Sortir de l'script"
    read -p "Que opcion desea? " option
}

function list_mods () {
    local i=0
    for file in $mods_available; do
        local existe=$(ls /etc/apache2/mods-enabled|grep ".load"|grep $file)
        
        if [ -z $existe ]; then
            echo -e "Linea $i: \e[91m$file\e[39m" #>> disabled.txt
        else
            echo -e "Linea $i: \e[92m$file\e[39m" #>> enabled.txt
        fi
        
        ((i++))
    done
}

function choose_option () {
    menu
    case $option in
        1)
            list_mods
        ;;
        2)
            echo "Activar MOD"
            activate_MOD
        ;;
        3)
            echo "Desactivar MOD"
            deactivate_MOD
        ;;
        [Ss])
            echo "Bye!"
            flag=false
        ;;
        *)
            echo -e "La opcion"$bold $option $white"es desconocida"
        ;;
    esac
}

function loop_menu () {
    local flag=true
    
    while $flag; do
        choose_option
    done
    
}

function activate_MOD () {
    local mod
    read -p "Que mod quieres activar? " mod
    
    local mods_enabled=`ls /etc/apache2/mods-enabled|grep $mod.load`
    
    if [ -z $mods_enabled ]; then
        echo "El mod $mod que quiere activar no esta en la lista de habilitados"
        echo "Activando..."
        #`cd /etc/apache2/mods-available/`
        sleep 1
        sudo a2enmod $mod
        echo "Restarting apache2..."
        sleep 1
        `systemctl restart apache2`
    else
        echo "Este mod $mod no puede habilitarse porque ya lo esta"
    fi
}

function deactivate_MOD () {
    local mod
    read -p "Que mod quieres desactivar? " mod
    
    local mods_enabled=`ls /etc/apache2/mods-enabled|grep $mod.load`
    
    if [ -z $mods_enabled ]; then
        echo "No se puede desactivar el modulo $mod porque no esta activado."
    else
        echo "Desactivando mod $mod"
        sudo a2dismod $mod
        `systemctl restart apache2`
        echo "MOD: $mod ha sido desactivado."
    fi
}

loop_menu #>> disabled.txt