#! /bin/bash
#source ./Apache_status/script.sh
#source Apache_status/functions.sh
#source Apache_directives/functions_directives.sh
# Menu principal
source ./config.sh
flag=true
function menu () {
    local option
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
        S)
            flag=false
            echo "Bye!"
            clear
        ;;
        *)
            echo -e "Opción $option incorrecta"
        ;;
    esac
}

while [ "$flag" = "true" ]; do
    menu
done