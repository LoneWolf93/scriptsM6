#!/bin/bash

#Scripts senzills II
#1. Mostra la primera aparició d'una cadena en un arxiu
#2. Mostrar el número de línia de la primera aparició d’una cadena
#3. Mostrar la posició del primer caràcter que és una lletra amb rang [a-Z] en una línia que comença per espais en blanc
#4. Busca una cadena en un arxiu i afegeix una cadena de text a continuació
#5. Repeteix el punt anterior però ara el text està desat en una variable.
#6. Genera una cadena amb un número determinat d'espais en blanc a l'inici, per exemple 4 

ejercicio1 () {
    `grep -m 1 "hola" file`
}

ejercicio2 () {
    `grep -n -m 1 "hola" file`
}


ejercicio3 () {

echo "Introduce la cadena para buscarla en el fichero"
read string
echo "Escribe la ruta absoluta del fichero"
read path

echo `grep "$string" $path | grep --only-matching --byte-offset '[A-Za-z]' | head -n 1`
}



ejercicio4 () {

    echo "Escribe la palabra para buscarla en el fichero"
    read word
    echo "Escribe la palabra para aniadirla en el fichero"
    read word2
    echo "Escribe la ruta absoluta del fichero"
    read path

    `sed -i "/$word/a $word2" $path`
}

ejercicio5 () {
    text="Hola que tal estas"

    echo "Escribe la palabra para buscarla en el fichero"
    read word
    #echo "Escribe la palabra para aniadirla en el fichero"
    #read word2

    `sed -i "/$word/a $text" prueba`

    #echo $text
}

ejercicio6 () {
    `printf "%*s%s" 4 > fichero-espacios.txt`
}

showMenu () {
    echo -e "\nIndica el tipus de configuracio"
    echo -e "\n  [1] Estatica"
    echo "  [2] DHCP"
    echo -e "  [3] Sortir\n"
    read -p "Introduce una opcion valida: " option
}

ejercicio7 () {
    # Cogemos el número de espacios de la primera letra en el apartado Interfaces
    space_inet=`grep "enp3s0:" 01-netcfg.yaml|grep -ob '[a-zA-Z]'|head -n 1|cut -d : -f1`
    # Cogemos el número de espacios para el parámetro DHCP4 por ejemplo
    space_dhcp=`grep "dhcp4:" 01-netcfg.yaml|grep -ob '[a-zA-Z]'|head -n 1|cut -d : -f1`
    # Variable para entrar en el bucle while
    flag=true
    # Inicialización de la variable para concatenar los resultados
    globales=""
    # Variable que contiene el comando printf y así mostrar los espacios de la interficie
    space=`printf "%*s%s" $space_inet`
    # Variable que contiene el comando printf y asi mostrar los espacios del parámetro dhcp4
    space2=`printf "%*s%s" $space_dhcp`


    # Mientras $flag sea True entro en el bucle
    while $flag; do

    # Invocamos a la función showMenu
    showMenu

    # En caso de que la opción sea 1,2 o 3 que haga una de la opciones si es
    # diferente muestra un mensaje de error
    case $option in
            1)
                # En cada opcion volvemos a poner la variable vacía para prevenir el concatenado de la
                # segunda opción.
                globales=""
                read -p "Introduce el nombre de la interficie de red: " IFACE
                read -p "Introduce la IP: " IP
                read -p "Introduce el dhcp true/false: " DHCP
                read -p "Introduce la puerta de enlace: " GW
                read -p "Introduce el DNS separado por comas: " DNS
                globales+="$space$IFACE:\n"
                globales+="$space2""addresses: [$IP]\n"
                globales+="$space2""dhcp4: $DHCP\n"
                globales+="$space2""gateway4: $GW\n"
                globales+="$space2""nameservers:\n"
                globales+="$space$space""addresses: [$DNS]"
                # Comando para insertar toda la variable concatenada a un fichero
                `sed -i '/ethernets:/a\'"$globales"'' 01-netcfg.yaml`
                ;;
            2)
                # En cada opcion volvemos a poner la variable vacía para prevenir el concatenado de la
                # primera opción.
                globales=""
                read -p "Introduce el nombre de la interficie de red: " IFACE2
                read -p "Quieres poner el dhcp?" DHCP2
                globales+="$space$IFACE2:\n"
                globales+="$space2""dhcp4: $DHCP2"
                # Comando para insertar toda la variable concatenada a un fichero
                `sed -i '/ethernets:/a\ '"$globales"'' 01-netcfg.yaml`
                ;;
            3)
                # Mensaje de despedida del programa
                echo "Bye!"
                # La variable se $flag que estaba en True se vuelve False
                flag=false
                ;;
            *)
                # Mensaje de error si el usuario inserta un valor diferente a 1, 2 o 3
                echo -e "\e[31mError, esta opcion no existe\e[0m"
                ;;
# End of case
esac
# End of loop
done
}


#########################################################################################################
###################################     Llamada de las funciones    #####################################
#########################################################################################################

#ejercicio1
#ejercicio2
#ejercicio3
#ejercicio4
#ejercicio5
#ejercicio6
ejercicio7

