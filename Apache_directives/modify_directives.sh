#! /bin/bash
function modify_menu () {
    flag_menu=false
    local option_modify
    #echo "Listado de ficheros"
    #ls /etc/apache2/sites-available
    echo -e "Current site $inverted[$current_site]$white"
    echo "[1] Add directive"
    echo "[2] Modify directive"
    echo "[3] Delete directive"
    echo "[S] Exit"
    read -p "Que opcion desea? " option_modify
    
    case $option_modify in
        1)
            clear
            mostrar_fichero
            add_directive
        ;;
        2)
            clear
            mostrar_fichero
            modify_directive
        ;;
        3)
            clear
            mostrar_fichero
            delete_directive
        ;;
        S)
            echo "atras"
            flag=false
        ;;
        *)
            echo "Opcion invalida"
        ;;
    esac
}

function mostrar_fichero () {
    ###
    local file_exists=false
    #current_site=""
    read -p "Que fichero quieres modificar? " mod_file_site
    
    for file in `ls /etc/apache2/sites-available/`; do
        
        if [ "$mod_file_site" = "$current_site" ]; then
            file_exists=true
        fi
        
        
        if [ "$file" = "$mod_file_site.conf" ]; then
            file_exists=true
        fi
    done
    
    if [ $file_exists = "true" ]; then
        if [ ! -z "$mod_file_site" ]; then
            current_site=$mod_file_site
            echo -e $bold"Current site -->$white $inverted[$current_site]$white"
        #else
         #   current_site=$mod_file_site
        fi
    fi
}

function add_directive () {
    cat -n /etc/apache2/sites-available/$current_site".conf"
    
    read -p "Que parametro deseas añadir? " add_param
    read -p "En que linea deseas añadirlo? " set_line
    sudo sed -i $set_line'a '"$tabs$add_param" /etc/apache2/sites-available/$current_site".conf"
}

function modify_directive () {
    local set_line
    cat -n /etc/apache2/sites-available/$current_site.conf
    read -p "Que numero de linea quieres modificar? " set_line
    #read -p "text antiguo " old_text
    read -p "text nuevo: " new_text
    hola=`sudo sed $set_line'q;d' /etc/apache2/sites-available/$current_site.conf | cut -d " " -f2`
    `sudo sed -i $set_line's;'$hola';'$new_text';' "/etc/apache2/sites-available/$current_site.conf"`
echo $hola
}

function delete_directive () {
    cat -n /etc/apache2/sites-available/$current_site.conf
    read -p "Que directiva deseas eliminar? " directive_line

    
    
    if [ ! -z $directive_line ]; then
        sudo sed -i $directive_line'd ' /etc/apache2/sites-available/$current_site.conf
        else
        echo "Error no ha introducido nada!!!"
    fi
    
    
}

while [ "$flag_menu" = "true" ]; do
   modify_menu
done