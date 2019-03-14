#!/bin/bash

# Funcion menu

function showMenuRunning () {
    echo -e "Estado actual: $1"
    echo "[Stop] Parar servicio"
    echo "[Exit] Salir del programa"
    read -p "Que desea hacer con el servicio $2?" option
}

function showMenuStopped () {
    echo -e "Estado actual: $1"
    echo "[Start] Iniciar servicio"
    echo "[Reboot] Reiniciar servicio"
    echo "[Stop] Parar servicio"
    echo "[Exit] Salir del programa"
}