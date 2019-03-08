#!/bin/bash

if [ $1 -gt $2 ]
then
	echo $1 "es mas grande que" $2
elif [ $2 -gt $1 ]
then
	echo $2 "es mas grande que" $1
else
	echo "son iguales"
fi
