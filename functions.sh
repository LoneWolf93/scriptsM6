#!/bin/bash

# Funcion menu

function showMenuStopped () {
    echo -e "\nEstado actual: \e[48;5;9m$1\e[0m"
    echo -e "\n[\e[38;5;76m  Start  \e[39m] Iniciar servicio"
    echo -e "[\e[38;5;247m  Exit   \e[39m] Salir del programa\n"
    read -p "Que desea hacer con el servicio $2? " option
    
    case $option in
        [Ss]tart)
            `systemctl start $2`
            ;;
        [Ee]xit)
            echo "Bye!"
            flag=false
            exit
            ;;
        *)
            echo -e "\e[91mError, opcion desconocida\e[39m"
            ;;
    esac

}

function showMenuRunning () {
    echo -e "\nEstado actual: \e[48;5;34m$1\e[0m"
    #echo -e "[\e[38;5;76m  Start  \e[39m] Iniciar servicio"
    echo -e "\n[\e[38;5;208m  Reboot \e[39m] Reiniciar servicio"
    echo -e "[\e[91m  Stop   \e[39m] Parar servicio"
    echo -e "[\e[38;5;247m  Exit   \e[39m] Salir del programa\n"
    read -p "Que desea hacer con el servicio $2? " option

    case $option in
        [Rr]eboot)
            echo "Reiniciando $2..."
            sleep 1
            `systemctl restart $2`
            ;;
        [Ss]top)
            echo "Parando $2..."
            sleep 1
            `systemctl stop $2`
            ;;
        [Ee]xit)
            echo "Bye!"
            flag=false
            exit
            ;;
        *)
            echo -e "\e[91mOpciones validas {Reboot | Stop}\e[39m"
            ;;
    esac
}