#! /bin/bash

# Funcion para visualizar el estado del servicio
function checkService () {
    status_apache2=$(systemctl status apache2 | grep "active" | cut -d " " -f 5)
    
    
    
    if [ "$status_apache2" != "active" ]; then
        echo "no esta activo"
    else
        echo "esta activo"
        echo "Hola esto es una prueba" #| mail -s "your subject" albert.esparrell@gmail.com
    fi
    
    
}
checkService