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
	Bienvenido Usuario ${ORANGE}$USER${NC} al programa de Funcionalidades.

    	Usted tiene las siguientes opciones:

	${CYAN}1${NC} - ${ORANGE}Ver Procesos${NC}
	${CYAN}2${NC} - ${ORANGE}Ver uso de RAM${NC}
    	${CYAN}3${NC} - ${ORANGE}Ver info de CPU (Btop +gráfico)${NC}
    	${CYAN}4${NC} - ${ORANGE}Ver info de Mem (Htop +gráfico)${NC}
	${CYAN}5${NC} - ${ORANGE}Conocer Top5 Sistemas de Ficheros Con Menos Espacio%${NC}

	${CYAN}99${NC} - ${ORANGE}Volver${NC}

"
	read -rp "	Ingrese Opción: " op

#	5-
#	6-
#	7-
#	8-


	case $op in
		1)
		 bash CommandTop.sh
		;;
		2)
		 clear
		 free -m -h
		 intro
		 bash Funcionalidades.sh
		;;
		3)
		 clear
		 btop
		 intro
		 bash Funcionalidades.sh
		;;
		4)
		 clear
		 htop
		 intro
		 bash Funcionalidades.sh
		;;
		5)
		 clear
		 df -h | awk '{print $5 " " $6}' | sort -n | tail -5 | tac
		 intro
		 bash Funcionalidades.sh
		;;
		99) # volver
		 clear
		 bash ./Inicio.sh
		;;
		*)
		 clear
		 printf "	${RED}Error, por favor introduce una opción correcta.${NC}"
		 intro
		 bash Funcionalidades.sh
		;;
	esac

