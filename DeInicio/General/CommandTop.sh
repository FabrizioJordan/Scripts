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
        echo "The file \"$file\" was not found or could not be read."
    fi
}



intro(){
	read -rp "	<INTRO>"
}

commandTopCPU(){
clear
./TopExpectCPU.expect
}

commandTopMEM(){
clear
./TopExpectMEM.expect
}

clear
echo -e "
 	Welcome User ${ORANGE}$USER${NC} to the computing top center.

    	You have the following options:

	${CYAN}1${NC} - ${ORANGE}See top for %CPU${NC}
	${CYAN}2${NC} - ${ORANGE}See top for %MEM${NC}

	${CYAN}99${NC} - ${ORANGE}Back${NC}

	${RED}Q${NC} - ${ORANGE}Exit${NC}

"

read -rp " 	Enter option : " op

case $op in
	1)
	 clear
	 commandTopCPU
	 inicio
	 bash CommandTop.sh
	;;
	2)
	 clear
	 commandTopMEM
	 inicio
	 bash CommandTop.sh
	;;
	99)
	 clear
	 inicio
	 bash Funcionalidades.sh
	;;
	Q)
	 clear
	 exit
	*)
	 clear
	 printf "	${RED}Error, por favor introduce una opción correcta${NC}\n"
	 inicio
	 bash CommandTop.sh
	;;
esac


