#!/bin/bash

source ./Apache_mods/functions_mods.sh

function menu () {
    echo -e "##########################"
    echo -e "########  Modules  #######"
    echo -e "##########################"
    echo -e "# [1] Llistar moduls     #"
    echo -e "# [2] Activat modul      #"
    echo -e "# [3] Desactivar modul   #"
    echo -e "# [S] Sortir de l'script #"
    echo -e "##########################"
    read -p "Que opcion desea? " option

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
            flag_modules=false
            clear
        ;;
        *)
            echo -e $color_error"La opcion"$bold $option "es desconocida"$white
        ;;
    esac
}


    flag_modules=true
    
    while [ "$flag_modules" = "true" ]; do
        menu
    done