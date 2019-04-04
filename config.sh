#! /bin/bash
function menu_conf () {
read -p "Ruta servicio apache: " ruta
read -p "Color para los errores: " color_error

if [ "$color_error" = "rojo" ]; then
    color_error="\e[31m"
fi

export color_error
export ruta


#export red="\e[31m"
export white="\e[0m"
export inverted="\e[7m"
export bold="\e[1m"
}