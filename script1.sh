#! /bin/bash

# Funcion para visualizar el estado del servicio
function checkService () {
    status_apache2=$(systemctl status apache2 | grep "active" | cut -d " " -f 5)
    
    if [ "$status_apache2" != "active" ]; then
        echo "El servicio esta parado, avisando al administrador" | mail -s "Peligro servicio parado" albert.esparrell@gmail.com
        for (( intentos=0; intentos<=4; intentos++ )); do
            status_apache2=$(systemctl status apache2 | grep "active" | cut -d " " -f 5)
            $(service apache2 restart)
        done
        if [ "$status_apache2" = "active" ]; then
            echo "El servicio esta activo, todo Ok" | mail -s "Servicio activo" albert.esparrell@gmail.com
        fi
    else
        echo "esta activo"
    fi
    
    
}
checkService