#!/bin/bash

#Scripts senzills II
#1. Mostra la primera aparició d'una cadena en un arxiu
#2. Mostrar el número de línia de la primera aparició d’una cadena
#3. Mostrar la posició del primer caràcter que és una lletra amb rang [a-Z] en una línia que comença per espais en blanc
#4. Busca una cadena en un arxiu i afegeix una cadena de text a continuació
#5. Repeteix el punt anterior però ara el text està desat en una variable.
#6. Genera una cadena amb un número determinat d'espais en blanc a l'inici, per exemple 4 


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

#ejercicio6 () {
    #printf "%*s%s" 10 > espais.txt
#}

showMenu () {
    echo "Indica el tipus de configuracio"
    echo "  [1] Estatica"
    echo "  [2] DHCP"
    echo "  [3] Sortir"
    read option
}

ejercicio7 () {
    showMenu

    case $option in
            1)
                    echo "Introduce el nombre de la interficie de red"
                    read IFACE
                    echo "Introduce la IP"
                    read IP
                    echo "Introduce la puerta de enlace"
                    read GW
                    echo "Introduce el DNS separado por comas"
                    read DNS
                    ;;
            2)
                    echo "Quieres poner el dhcp?"
                    ;;
            3)
                    echo "Bye!"
                    exit
                    ;;
esac

globales=""
globales+="$IFACE:\n"
globales+="addresses: [$IP]\n"
globales+="gateway4: $GW\n"
globales+="nameservers:\n"
globales+="addresses: [$DNS]"
echo -e $globales < 01-netcfg.yaml
}

ejercicio7

