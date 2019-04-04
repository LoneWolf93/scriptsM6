#! /bin/bash

source ./Apache_directives/functions_modificar.sh

function modify_menu () {
    clear
    flag_menu=true
    #local option_modify
    #echo "Listado de ficheros"
    #ls /etc/apache2/sites-available
    echo -e "Current site $inverted[$current_site]$white"
    echo "[1] Add directive"
    echo "[2] Modify directive"
    echo "[3] Delete directive"
    echo "[S] Exit"
    read -p "Que opcion desea? " option_modify
    
    case $option_modify in
        1)
            clear
            mostrar_fichero
            add_directive
            loop_menu
        ;;
        2)
            clear
            mostrar_fichero
            modify_directive
            loop_menu
        ;;
        3)
            clear
            mostrar_fichero
            delete_directive
            loop_menu
        ;;
        S)
            echo "atras"
            flag_menu=false
        ;;
        *)
            echo "Opcion invalida"
            loop_menu
        ;;
    esac
}

function loop_menu () {
while [ "$flag_menu" = "true" ]; do
   modify_menu
done
}