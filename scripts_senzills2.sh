#!/bin/bash

k=1

for linea in `ls /etc`
do
	echo Linea $k $linea
	((k++))
done
