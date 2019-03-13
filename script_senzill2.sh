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
    # Cogemos el numero de espacios de la primera letra en el apartado Interfaces
    space_inet=`grep "enp3s0:" 01-netcfg.yaml|grep -ob '[a-zA-Z]'|head -n 1|cut -d : -f1`
    space_dhcp=`grep "dhcp4:" 01-netcfg.yaml|grep -ob '[a-zA-Z]'|head -n 1|cut -d : -f1`
    flag=true
    globales=""
    space=`printf "%*s%s" $(($space_inet - 1))`
    space2=`printf "%*s%s" $space_dhcp`
    sumaspaces=$(($space_inet + $space_dhcp))
    space3=`printf "%*s%s" $sumaspaces`

    while $flag; do

    # Invoke method showMenu
    showMenu

    case $option in
            1)
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
                globales+="$space3""addresses: [$DNS]"

                `sed -i '/ethernets:/a\ '"$globales"'' 01-netcfg.yaml`
                #echo -e "$globales"
                ;;
            2)
                read -p "Introduce el nombre de la interficie de red: " IFACE
                read -p "Quieres poner el dhcp?" DHCP
                globales+="$space$IFACE:\n"
                globales+="$space2""dhcp4: $DHCP"
                `sed -i '/ethernets:/a\ '"$globales"'' 01-netcfg.yaml`
                ;;
            3)
                echo "Bye!"
                flag=false
                ;;
            *)
                echo -e "\e[31mError, esta opcion no existe\e[0m"
                ;;
# End of case
esac
# End of loop
done
}

ejercicio7

