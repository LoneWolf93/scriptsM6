#! /bin/bash

# Muestra el fichero que estamos modificando
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

# Funcion que añade una directiva pasa por el usuario por consola
function add_directive () {
    cat -n /etc/apache2/sites-available/$current_site".conf"
    read -p "En que linea deseas añadirlo? " set_line
    read -p "Que parametro deseas añadir? " add_param
    read -p "Cuantas tabulaciones quieres? " tab

    if [ "$tab" = "1" ]; then
    tab="\t"
    #`sudo sed -i $set_line'a '"$add_param" /etc/apache2/sites-available/$current_site".conf"`
    sudo sed -i $set_line'i;'$tab';'$add_param /etc/apache2/sites-available/$current_site.conf
    else
    tab='\t'
    sudo sed -i $set_line'i'';'$tab$tab';'$add_param /etc/apache2/sites-available/$current_site.conf
    fi
}

# Funcion que modifica una directiva introduciendo el numero de linea y escribiendo la
# nueva directiva.
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

# Funcion para eliminar una directiva especifica pasando por consola el numero de linea
# de dicha directiva.
function delete_directive () {
    cat -n /etc/apache2/sites-available/$current_site.conf
    read -p "Que directiva deseas eliminar? " directive_line

    if [ ! -z $directive_line ]; then
        sudo sed -i $directive_line'd ' /etc/apache2/sites-available/$current_site.conf
    else
        echo "Error no ha introducido nada!!!"
    fi
}

# Funcion para modificar el sitio
function modify_site () {
    echo "Function de modificar"
    #source ./Apache_directives/modify_directives.sh
    modify_menu
}


