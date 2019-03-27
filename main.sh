#! /bin/bash

#source Apache_directives/functions_directives.sh
# Menu principal
function menu () {
    local option
    echo "[1] Administrar server"
    echo "[2] Administrar modulos"
    echo "[3] Administrar sites"
    echo "[S] Salir del programa"
    read -p "Que opcion deseas? " option
}


menu


