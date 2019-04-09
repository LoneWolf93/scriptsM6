#! /bin/bash
source err.sh
# Menu principal
source ./vars.sh
flag=true
function menu () {
    local option
    echo -e "###########################"
    echo -e "####### $bold Main menu  $white#######"
    echo -e "###########################"
    echo "# [1] Administrar server  #"
    echo "# [2] Administrar modulos #"
    echo "# [3] Administrar sites   #"
    echo "# [4] Configuracion       #"
    echo "# [S] Salir del programa  #"
    echo -e "###########################"
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
            menu_configuration
        ;;
        S)
            flag=false
            echo "Bye!"
            clear
        ;;
        *)
            clear
            echo -e $err_color"Opción $option incorrecta"$white
        ;;
    esac
}

while [ "$flag" = "true" ]; do
    menu
done