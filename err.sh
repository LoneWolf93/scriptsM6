#! /bin/bash

set -e

function err () {

    fecha=$(date +%d/%m/%Y)
    hora=$(date +%H:%M:%S)
    #day=$(date +%d)
    #month=$(date +%m)
    #year=$(date +%Y)

    echo "el dia $fecha a las $hora hubo un error en la linea $2 en el script $1 en la funcion $3"

    #exit $retval

}
trap 'err ${BASH_SOURCE[0]} $LINENO ${FUNCNAME[0]}' ERR