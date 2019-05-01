#! /bin/bash

# Funcion para visualizar el estado del servicio
function checkService () {
    status_apache2=$(systemctl status apache2 | grep "active" | cut -d " " -f 5)
    fecha=$(date +"%d-%m-%Y")
    hora=$(date +"%H:%M:%S")
    
    if [ "$status_apache2" != "active" ]; then
        echo "El servicio esta parado, avisando al administrador" | mail -s "Peligro servicio parado" albert.esparrell@gmail.com
        echo "Se registró un incidente a las $hora del dia $fecha Incidente en el estado del servicio. Estado --> $status_apache2" >> informe.log
        for (( intentos=0; intentos<=4; intentos++ )); do
            status_apache2=$(systemctl status apache2 | grep "active" | cut -d " " -f 5)
            $(systemctl restart apache2 --no-ask-password)
        done
        if [ "$status_apache2" = "active" ]; then
            echo "El servicio esta activo, todo Ok" | mail -s "Servicio activo" albert.esparrell@gmail.com
        fi
    fi
    
}
checkService