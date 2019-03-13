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

    flag=true
    globales=""

    while $flag; do

    showMenu

    case $option in
            1)
                read -p "Introduce el nombre de la interficie de red: " IFACE
                read -p "Introduce la IP: " IP
                read -p "Introduce la puerta de enlace: " GW
                read -p "Introduce el DNS separado por comas: " DNS
                globales+="$IFACE:\n"
                globales+="addresses: [$IP]\n"
                globales+="gateway4: $GW\n"
                globales+="nameservers:\n"
                globales+="addresses: [$DNS]"
                echo -e $globales
                ;;
            2)
                echo "Quieres poner el dhcp?"
                ;;
            3)
                echo "Bye!"
                flag=false
                ;;
            *)
                echo -e "\e[31mError, esta opcion no existe\e[0m"
# End of case
esac
# End of loop
done

space_inet=`grep "enp3s0:" 01-netcfg.yaml|grep -ob '[a-zA-Z]'|head -n 1|cut -d : -f1`
#`sed -i "/ethernets:/a $globales" 01-netcfg.yaml`
}

ejercicio7

