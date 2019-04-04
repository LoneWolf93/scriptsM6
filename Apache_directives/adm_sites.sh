#! /bin/bash
source ./Apache_directives/modificar.sh
source ./Apache_directives/crear.sh
# Menu sites
function menu_sites () {
    local option_site
    
    echo "[1] Create site"
    echo "[2] Modify site"
    echo "[3] Delete site"
    echo "[4] Enable site"
    echo "[5] Disable site"
    echo "[S] Exit"
    read -p "Escriba una opcion " option_site
    
    case $option_site in
        1)
            #Llamo a la funcion de crear sitio
            create_site
        ;;
        2)
            #Llamo a la funcion de modificar
            modify_menu
        ;;
        3)
            #Llamo a la funcion de eliminar sitio
            delete_site
        ;;
        4)
            #Llamo a la funcion de habilitar sitio
            enable_site
        ;;
        5)
            #Llamo a la funcion de deshabilitar sitio
            disable_site
        ;;
        S)
            clear
            flag_sites=false
        ;;
        *)
            #Cualquier opcion diferente hace un output de mensaje de error
            echo "Opcion incorrecta :("
        ;;
    esac
}

flag_sites=true

while [ "$flag_sites" = "true" ]; do
    menu_sites
done