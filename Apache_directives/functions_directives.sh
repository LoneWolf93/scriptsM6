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
    local name_site
    local file_exists=false
    local IP
    local foo
    read -p "Como se llamara el fichero? " name_site
    
    #Crea un fichero en blanco
    
    $(cd /etc/apache2/sites-available/)
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
    fi

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

    foo+="<VirtualHost $IP:$PORT>\n"
    foo+="ServerAdmin $EMAIL\n"
    #foo+= "DocumentRoot $DOCUMENTROOT "
    #foo+="\n"
    #foo+="ErrorLog $ERRORLOG"
    #foo+="\n"
    #foo+="CustomLog $CUSTOMLOG"
    #foo+="\n"
    #foo+="Directory $DOCUMENTROOT"
    #foo+="\n"
    #foo+="AuthType $AUTHTYPE\n"
    #foo+="AuthUserFile $AUTHUSERFILE"
    #foo+="\n"
    #foo+="Require $REQUIRE\n"
    #foo+="</Directory>\n"
    #foo+="</Virtualhost>"
#sudo su
    echo -e "$foo" >> "/etc/apache2/sites-available/$name_site.conf"

}

function modify_site () {
    echo "Function de modificar"
}

function go_Back () {
    cd ..
    source main.sh
}