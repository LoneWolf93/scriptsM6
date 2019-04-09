#! /bin/bash

export ruta="/etc/apache2/"
export color_error="\e[31m"
export white="\e[0m"
export inverted="\e[7m"
export bold="\e[1m"

function menu_conf () {
    
    local color_exists=false
    local option_config
    echo "[1] Cambiar color error"
    echo "[2] Cambiar ruta por defecto"
    echo "[S] Salir"

    read -p "Que opcion deseas? " option_config
    #read -p "Ruta servicio apache: " ruta
    
    
    case $option_config in
    1)
    cambiar_color
    ;;
    S)
    flag_config=false
    echo "Bye!"
    ;;
    esac
    
}

function cambiar_color () {

read -p "Color para los errores: " color_error

available_colors=("rojo" "verde" "blanco" "cyan" "magenta")
    
    i=0
    while [ $i -lt ${#available_colors[@]} ]; do
        if [ "$color_error" = "${available_colors[$i]}" ]; then
            color_exists=true
        fi
        ((i++))
    done
    
    if [ "$color_exists" = "true" ]; then
        case $color_error in
            rojo)
                color_error="\e[31m"
            ;;
            verde)
                color_error="\e[32m"
            ;;
            blanco)
                color_error="\e[39m"
            ;;
            cyan)
                color_error="\e[36m"
            ;;
            magenta)
                color_error="\e[95m"
            ;;
            *)
            echo "Error "
        esac 
    else
        echo "El color no existe!"
    fi
    
    export color_error
    export ruta
    
    
    #export red="\e[31m"
    export white="\e[0m"
    export inverted="\e[7m"
    export bold="\e[1m"
    
    echo $color_error

    
}

function loop () {
flag_config=true

while [ "$flag_config" = "true" ]; do
menu_conf
done
}


