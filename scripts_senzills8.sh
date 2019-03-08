#!/bin/bash

rm $1 2>/dev/null

if [ $? -eq 0 ]
then
	echo "Se ha eliminado correctamente"
	#echo "codigo de error: "$?
else 
	echo "Ha habido un error"
	#echo "Codigo de error: "$?
fi
