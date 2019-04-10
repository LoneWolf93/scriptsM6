#! /bin/bash

# Funcion para crear el sitio
function create_site () {
    #name_site
    local file_exists=false
    
    read -p "Como se llamara el fichero? " name_site

    #Recorre todo el directorio sites-available para comprobar si existe o no el fichero
    #que introducimos.
    for file in `ls $ruta/sites-available/`; do
        if [ "$name_site.conf" = "$file" ]; then
            file_exists=true
        fi
    done
    #Si el fichero existe no hace nada,
    #Si el fichero NO existe lo crea.
    if [ $file_exists = "true" ]; then
        echo "El fichero $name_site existe!"
    else
        echo "El fichero no existe, El fichero $name_site ha sido creado"
        $(sudo touch $ruta/sites-available/$name_site.conf)
        set_parameters
    fi
}

# Funcion para agregar parametros al crear el sitio
function set_parameters () {
    local IP
    local PORT
    local DOCUMENTROOT
    local ERRORLOG
    local CUSTOMLOG
    local AUTHTYPE
    local AUTHUSERFILE
    local REQUIRE
    local foo
    local tabs
    #Creacion de los parametros que contiene dicho fichero creado anteriormente
    
    read -p "Que direccion IP? " IP
    read -p "Que puerto? " PORT
    read -p "Que serverAdmin? " EMAIL
    read -p "Que document root? " DOCUMENTROOT
    read -p "Que error log? " ERRORLOG
    read -p "Que custom log? " CUSTOMLOG
    read -p "Que auth type? " AUTHTYPE
    read -p "Que auth user file? " AUTHUSERFILE
    read -p "Que require? " REQUIRE
    
    #Crea ocho espacios
    #tabs=`printf "%*s%s" 8`
    tabs="\t"
    foo+="<VirtualHost $IP:$PORT>\n"
    foo+=$tabs"ServerAdmin $EMAIL\n"
    foo+=$tabs"DocumentRoot $DOCUMENTROOT\n"
    foo+=$tabs"ErrorLog $ERRORLOG\n"
    foo+=$tabs"CustomLog $CUSTOMLOG\n"
    foo+=$tabs"<Directory $DOCUMENTROOT>\n"
    foo+=$tabs$tabs"AuthType $AUTHTYPE\n"
    foo+=$tabs$tabs"AuthUserFile $AUTHUSERFILE\n"
    foo+=$tabs$tabs"Require $REQUIRE\n"
    foo+=$tabs"</Directory>\n"
    foo+="</Virtualhost>"
    
    #Guardamos todo el contenido de la variable a un fichero
    echo -e "$foo" >> "$name_site.conf"
    #Movemos el fichero que creamos hacia la carpeta de sites-available
    sudo mv -v $name_site".conf" $ruta/sites-available/$name_site".conf"
    
    #echo -e "$foo" >> "$ruta/sites-available/$name_site.conf"
    #echo -e "$foo" >> "$name_site.conf"
}

function delete_site () {
    local file_exists=false
    
    read -p "Como se llama el fichero? " site_to_delete

    #Recorre todo el directorio sites-available para comprobar si existe o no el fichero
    #que introducimos.
    for file in `ls $ruta/sites-available/`; do
        if [ "$site_to_delete.conf" = "$file" ]; then
            file_exists=true
        fi
    done

    if [ "$file_exists" = "true" ]; then
        `sudo rm $ruta/sites-available/$site_to_delete.conf`
    fi

    echo "Site eliminado correctamente! $(date +%d/%m/%Y %H:%M:%S)"
}

function list_site () {
    sudo ls -l $ruta/sites-available/
}