#!/bin/bash
IFS=$'\n'
i=1

for lineas in `cat prueba`
do
	echo Linea $i $lineas
	((i++))
done
