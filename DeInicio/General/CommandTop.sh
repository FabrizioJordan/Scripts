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
	Bienvenido Usuario ${ORANGE}$USER${NC} al centro del comamanto top.

    	Usted tiene las siguientes opciones:

	${CYAN}1${NC} - ${ORANGE}Ver top por %CPU${NC}
	${CYAN}2${NC} - ${ORANGE}Ver top por %MEM${NC}

	${CYAN}99${NC} - ${ORANGE}Volver${NC}

"

read -p "	Opción: " op
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
	*)
	 clear
	 printf "	${RED}Error, por favor introduce una opción correcta${NC}\n"
	 inicio
	 bash CommandTop.sh
	;;
esac


