#! /bin/bash

# Variables por defecto pre cargadas
export ruta="/etc/apache2"
export err_color="\e[31m"
export white="\e[39m"

# Menu para cambiar las variables export
function menu_configuration () {
    
    flag_configuration=true
    
    echo "[1] Rojo"
    echo "[2] Amarillo"
    echo "[3] ruta apache2 en ubuntu"
    echo "[4] ruta apache2 en fedora"
    echo "[S] Salir"
    
    read -p "Elije una opcion de configuracion: " option_configuration
    
    case $option_configuration in
        1)
            clear
            err_color="\e[31m"
            echo -e "Color cambiado a $err_color rojo $white"
        ;;
        2)
            clear
            err_color="\e[33m"
            echo -e "Color cambiado a $err_color amarillo $white"
        ;;
        3)
            clear
            ruta="/etc/apache2"
            echo -e "Ruta cambiada a $ruta"
        ;;
        4)
            clear
            ruta="/etc/httpd"
            echo -e "Ruta cambiada a $ruta"
        ;;
        S)
            clear
            flag_configuration=false
        ;;
    esac
    
    #read -p "Elije un color para los errores: " err_color
    #read -p "Elije una ruta? " ruta
    
    
    
    while [ "$flag_configuration" = "true" ]; do
        menu_configuration
    done
    
}