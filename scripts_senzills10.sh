#!/bin/bash

# Muestra el menu
showMenu () {
    echo "[1] Insertar una linea nueva a continuacion de una linea especifica"
    echo "[2] Insertar una linea nueva antes de una linea especifica"
    echo "[3] Cambiar el contenido de dos lineas de un archivo por dos palabras una por linea"

    echo "Introduce una opcion valida: "
    read option
  
}

insertAfter () {
    #Insertar linea a continuacion de una linea especificada
    echo "Introduce el numero de la linea"
    read line_num
    echo "Introduce la frase"
    read message
    echo "Introduce la ruta absoluta del fichero"
    read path
    `sed -i "$line_num a $message" $path`
    
}

insertBefore () {
    #Insertar linea a continuacion de una linea especificada
    echo "Introduce el numero de la linea"
    read line_num
    echo "Introduce la frase"
    read message
    echo "Introduce la ruta absoluta del fichero"
    read path
    `sed -i "$line_num i $message" $path`
}

changeContent () {
    echo "Introduce la primera linea"
    read first_line
    echo "Introduce la segunda linea" 
    read second_line
    echo "Introduce la primera palabra"
    read first_word
    echo "Introduce la segunda palabra"
    read second_word
    echo "Introduce la ruta absoluta del fichero"
    read path

    `sed -i "$first_line,$second_line c\$first_word\n$second_word" $path`
}

    showMenu

    case $option in
        1)
            insertAfter
            ;;
        2)
            insertBefore
            ;;
        3)
            changeContent
            ;;
    esac