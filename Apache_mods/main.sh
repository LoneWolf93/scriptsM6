#!/bin/bash

function menu () {
    echo -e "[1] Llistar moduls"
    echo -e "[2] Activat modul"
    echo -e "[3] Desactivar modul"
    echo -e "[S] Sortir de l'script"
}

#mods_enabled=`ls /etc/apache2/mods-enabled/ | grep ".load" | cut -d "." -f1`
mods_available=`ls /etc/apache2/mods-available/ | grep ".load"`

i=1
for files in $mods_available; do
    echo $files
    
    ((i++))
done