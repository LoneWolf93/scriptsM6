#!/bin/bash

case $2 in
	+)
	 echo "Resultado:" $(($1 + $3))
	 ;;
	-)
	 echo "Resultado:" $(($1 - $3))
	 ;;
	x)
	 echo "Resultado:" $(($1 * $3))
	 ;;
	div)
	 echo "Resultado:" $(($1 / $3))
	 ;;
esac
