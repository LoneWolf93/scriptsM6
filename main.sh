#! /bin/bash
#source ./Apache_status/script.sh
#source Apache_status/functions.sh
#source Apache_directives/functions_directives.sh
# Menu principal
source ./config.sh
flag=true
function menu () {
    local option
    echo -e "###########################"
    echo -e "####### $bold Main menu  $white#######"
    echo -e "$bold###########################$white"
    echo "# [1] Administrar server  #"
    echo "# [2] Administrar modulos #"
    echo "# [3] Administrar sites   #"
    echo "# [S] Salir del programa  #"
    echo -e "$bold###########################$white"
    read -p "Que opcion deseas? " option
    case $option in
        1)
            clear
            bash Apache_status/script.sh
        ;;
        2)
            clear
            bash Apache_mods/main.sh
        ;;
        3)
            clear
            bash Apache_directives/adm_sites.sh
        ;;
        4)
            clear
            menu_conf
        ;;
        S)
            flag=false
            echo "Bye!"
            clear
        ;;
        *)
            clear
            echo -e $color_error"Opción $option incorrecta"$white
        ;;
    esac
}

while [ "$flag" = "true" ]; do
    menu
done