#! /bin/bash
source Apache_status/script.sh
source Apache_status/functions.sh
#source Apache_directives/functions_directives.sh
# Menu principal
flag=true
function menu () {
    local option
    echo "[1] Administrar server"
    echo "[2] Administrar modulos"
    echo "[3] Administrar sites"
    echo "[S] Salir del programa"
    read -p "Que opcion deseas? " option
    case $option in
        1)
            clear
            administrar_server
        ;;
        2)
            clear
            administrar_modules
        ;;
        3)
            clear
            administrar_sites
        ;;
        S)
            flag=false
            echo "Bye!"
        ;;
        *)
            echo -e "Opción $option incorrecta"
        ;;
    esac
}

while [ "$flag" = "true" ]; do
    menu
done