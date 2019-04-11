#!/bin/bash

# Funcion menu para cuando el servicio apache esta parado

function showMenuStopped () {
    echo -e "\nEstado actual: \e[30;48;5;9m$1\e[0m"
    echo -e "\n[\e[38;5;76m  Start  \e[39m] Iniciar servicio"
    echo -e "[\e[38;5;247m  Exit   \e[39m] Salir del programa\n"
    read -p "Que desea hacer con el servicio $2? " option
    
    case $option in
        [Ss]tart)
            clear
            `sudo service $2 start`
        ;;
        [Ee]xit)
            echo "Bye!"
            flag=false
            #exit
        ;;
        *)
            clear
            echo -e $color_error"Error, opcion desconocida"$white
        ;;
    esac
    
}

# Funcion menu para cuando el servicio apache esta ejecutandose
function showMenuRunning () {

    echo -e "Hint: Opciones validas {Reboot | Stop | Reload | Exit}"

    echo -e "\nEstado actual: \e[30;48;5;34m$1\e[0m"
    #echo -e "[\e[38;5;76m  Start  \e[39m] Iniciar servicio"
    echo -e "\n[\e[38;5;208m  Reboot \e[39m ] Reiniciar servicio"
    echo -e "[  Reload  ]"
    echo -e "[\e[91m  Stop   \e[39m ] Parar servicio"
    echo -e "[\e[38;5;247m  Exit   \e[39m ] Salir del programa\n"
    read -p "Que desea hacer con el servicio $2? " option
    
    case $option in
        [Rr]eboot)
            echo "Reiniciando $2..."
            sleep 2
            clear
            #`systemctl restart $2`
            `sudo service $2 restart`
        ;;
        [Ss]top)
            echo "Parando $2..."
            sleep 2
            clear
            `sudo service $2 stop`
        ;;
        [Rr]eload)
            echo "Recargando $2..."
            sleep 2
            clear
            `sudo service $2 reload`
        ;;
        [Ee]xit)
            echo "Bye!"
            flag=false
            #exit
        ;;
        *)
            clear
            echo -e "\e[91mOpciones validas {Reboot | Stop | Reload}\e[39m"
        ;;
    esac
}