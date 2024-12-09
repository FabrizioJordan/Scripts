#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # no color


findResource() {
    local file="$1"
	local USER_HOME="$HOME"

    local fileType="$(echo "$file" | grep -oE '\.[^.]+$' | sed 's/\.//')"
    # Buscar archivos del mismo tipo que el archivo buscado
    filesOfType=$(find "$USER_HOME" -type f -name "*.$fileType" 2>/dev/null)
    # Buscar el archivo específico dentro de la lista de archivos del mismo tipo
    result=$(echo "$filesOfType" | grep "/$file$")
    # Verificar si se encontró el archivo antes de intentar ejecutarlo
    if [ -n "$result" ]; then
        bash "$result"
    else
        echo "El archivo \"$file\" no se encontró o no se puede leer."
    fi
}



intro(){
	read -rp "	<INTRO>"
}


clear

echo -e "

	Bienvenido usuario ${ORANGE}$USER${NC} a la modificación del sistema del Centro de Cómputos.

	Ingrese Opción:

	${CYAN}1${NC} - ${ORANGE}Lists information about all available or specified block devices${NC}
	${CYAN}2${NC} - ${ORANGE}Displays detailed information about the CPU${NC}


	${CYAN}99${NC} - ${ORANGE}Volver${NC}
"

read -rp "	Ingrese opcion : " op

case $op in
	1)
	 lsblk -l
	 intro
	 bash System.sh
	;;
	2)
	 lscpu | grep -v "Indicadores"
	;;
	99)
	 clear
	 bash System.sh
	;;
	*)
	 clear
	 printf "	${RED}Error, por favor introduce una opción correcta.${NC}"
	 intro
	 bash System.sh
	;;
esac
