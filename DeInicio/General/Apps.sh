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

    filesOfType=$(locate -ib "$file")
    result=$(echo "$filesOfType" | grep "/$file$")
    # Verificar si se encontró el archivo antes de intentar ejecutarlo
    if [ -n "$result" ]; then
        bash "$result"
    else
        echo "El archivo \"$file\" no se encontró o no se puede leer."
    fi
}


back(){
	./Apps.sh || findResource Apps.sh
}

intro(){
	read -rp "	<INTRO>"
}


clear

echo "
	Bienvenido usuario ${ORANGE}$USER${NC} a la elección de Apps del Centro de Cómputos.

	Ingrese Opción:

	${CYAN}1${NC} - ${ORANGE}VSCode${NC}
	${CYAN}2${NC} - ${ORANGE}Chrome${NC}
    	${CYAN}3${NC} - ${ORANGE}Configuración del Sistema${NC}
    	${CYAN}4${NC} - ${ORANGE}Bleachbit (sudo)${NC}
    	${CYAN}5${NC} - ${ORANGE}CPU-X${NC}
    	${CYAN}6${NC} - ${ORANGE}Joplin${NC}
    	${CYAN}7${NC} - ${ORANGE}Discord${NC}

	${CYAN}99${NC} - ${ORANGE}Volver${NC}

	${RED}Q${NC} - ${ORANGE}Exit${NC}
"

read -rp "	Ingrese opcion : " op

case $op in
	1)
	 code
	 back
	;;
	2)
	 google-chrome
	 back
	;;
	3)
	 cinnamon-settings
	 back
	;;
	4)
	 sudo bleachbit
	 back
	;;
	5)
	 cpu-x
	 back
	;;
	6)
	 /home/jordan/.joplin/Joplin.AppImage  %u
	 back
	;;
	7)
	 discord
	 back
	;;
	99)
	 clear
	 findResource Init.sh
	;;
	Q)
	 clear
	 exit
	;;
	*)
	 clear
	 printf "	${RED}Error, por favor introduce una opción correcta.${NC}"
	 intro
	 back
	;;
esac
