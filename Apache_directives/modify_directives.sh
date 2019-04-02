source functions_directives.sh
source ../config.sh
function modify_menu () {
    local option_modify
    #echo "Listado de ficheros"
    #ls /etc/apache2/sites-available
    echo -e "Current site $inverted[$current_site]$white"
    echo "Add directive"
    echo "Modify directive"
    echo "Delete directive"
    echo "Back"
    read -p "Que opcion desea? " option_modify
    
    case $option_modify in
        [Aa]dd)
            clear
            mostrar_fichero
            add_directive
        ;;
        [Mm]od)
            clear
            mostrar_fichero
            modify_directive
        ;;
        [Dd]elete)
            clear
            mostrar_fichero
            delete_directive
        ;;
        [Bb]ack)
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
        else
            current_site=$mod_file_site
            
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
    cat -n /etc/apache2/sites-available/$current_site.conf
    
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

while $flag; do
    modify_menu
done