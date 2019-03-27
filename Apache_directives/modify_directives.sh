source functions_directives.sh

function modify_menu () {
    local option_modify
    echo "Listado de ficheros"
    ls /etc/apache2/sites-available
    echo "Add directive"
    echo "Modify directive"
    echo "Delete directive"
    echo "Back"
    read -p "Que opcion desea? " option_modify
    
    case $option_modify in
        [Aa]dd)
            add_directive
        ;;
        [Mm]od)
            modify_directive
        ;;
        [Dd]elete)
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

function add_directive () {
    local mod_file_site
    local file_exists=false
    read -p "Que fichero quieres modificar? " mod_file_site

    for file in `ls /etc/apache2/sites-available/`; do
        if [ "$file" = "$mod_file_site.conf" ]; then
            file_exists=true
        else
            file_exists=false
        fi
        
    done
    
    if [ $file_exists = "true" ]; then
        cat -n /etc/apache2/sites-available/$mod_file_site".conf"
    else
        echo "nose"
    fi

}

while $flag; do
    modify_menu
done