#! /bin/bash
source ./Apache_directives/modificar.sh
source ./Apache_directives/crear.sh
# Menu sites
function menu_sites () {
    local option_site
    echo -e "#####################"
    echo -e "#####   Sites   #####"
    echo -e "#####################"
    echo -e "# [1] Create site   #"
    echo -e "# [2] Modify site   #"
    echo -e "# [3] Delete site   #"
    echo -e "# [4] Enable site   #"
    echo -e "# [5] Disable site  #"
    echo -e "# [S] Exit          #"
    echo -e "#####################"
    read -p "Escriba una opcion " option_site
    
    case $option_site in
        1)
            #Llamo a la funcion de crear sitio
            create_site
        ;;
        2)
            #Llamo a la funcion de modificar
            modify_menu
        ;;
        3)
            #Llamo a la funcion de eliminar sitio
            delete_site
        ;;
        4)
            #Llamo a la funcion de habilitar sitio
            enable_site
        ;;
        5)
            #Llamo a la funcion de deshabilitar sitio
            disable_site
        ;;
        S)
            clear
            flag_sites=false
        ;;
        *)
            #Cualquier opcion diferente hace un output de mensaje de error
            echo "Opcion incorrecta :("
        ;;
    esac
}


function enable_site () {
    local site_to_enable
    local file_exists=false
    read -p "Que fichero de configuracion quieres habilitar? " site_to_enable
    
    for file in `ls /etc/apache2/sites-available/`; do
        if [ "$site_to_enable.conf" = "$file" ]; then
            file_exists=true
        fi
    done
    
    if [ "$file_exists" = "true" ]; then
        cd /etc/apache2/sites-available/
       `sudo a2ensite "$site_to_enable"`
        `sudo systemctl reload apache2`
        echo -e "Sitio habilitado correctamente!"
    fi
}


flag_sites=true

while [ "$flag_sites" = "true" ]; do
    menu_sites
done