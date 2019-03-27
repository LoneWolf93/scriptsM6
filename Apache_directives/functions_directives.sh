# Menu sites
function menu_sites () {
    
    local option_site
    
    echo "Create site"
    echo "Modify site"
    echo "Delete site"
    echo "Enable site"
    echo "Disable site"
    echo "backward"
    read -p "Escriba una opcion " option_site
    
    case $option_site in
        [Cc]reate)
            #Llamo a la funcion de crear sitio
            create_site
        ;;
        [Mm]odify)
            #Llamo a la funcion de modificar
            modify_site
        ;;
        [Dd]elete)
            #Llamo a la funcion de eliminar sitio
            delete_site
        ;;
        [Ee]nable)
            #Llamo a la funcion de habilitar sitio
            enable_site
        ;;
        [Dd]isable)
            #Llamo a la funcion de deshabilitar sitio
            disable_site
        ;;
        [Bb])
            #Llamo a la funcion de ir hacia atras
            go_Back
        ;;
        *)
            #Cualquier opcion diferente hace un output de mensaje de error
            echo "Opcion incorrecta :("
        ;;
    esac
}

function create_site () {
    #name_site
    local file_exists=false
    
    read -p "Como se llamara el fichero? " name_site

    #Recorre todo el directorio sites-available para comprobar si existe o no el fichero
    #que introducimos.
    for file in `ls /etc/apache2/sites-available/`; do
        if [ "$file" = "$name_site.conf" ]; then
            file_exists=true
        else
            file_exists=false
        fi
        
    done
    #Si el fichero existe no hace nada,
    #Si el fichero NO existe lo crea.
    if [ $file_exists = "true" ]; then
        echo "El fichero $name_site existe!"
    else
        echo "El fichero no existe, El fichero $name_site ha sido creado"
        $(sudo touch /etc/apache2/sites-available/$name_site.conf)
        set_parameters
    fi
}

function modify_site () {
    echo "Function de modificar"
    source modify_directives.sh
    modify_menu
}

function go_Back () {
    cd ..
    source main.sh
}

#Parametros del fichero
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
    tabs=`printf "%*s%s" 8`

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
    sudo mv -v $name_site".conf" /etc/apache2/sites-available/$name_site".conf"
    
    #echo -e "$foo" >> "/etc/apache2/sites-available/$name_site.conf"
    #echo -e "$foo" >> "$name_site.conf"
}