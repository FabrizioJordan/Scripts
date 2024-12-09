#!/bin/bash

#a agregar:


RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # no color


intro(){
	read -rp "	<INTRO>"
}

findResource() {
    local file="$1"
	local USER_HOME="$HOME"

		#with find command
    #local fileType="$(echo "$file" | grep -oE '\.[^.]+$' | sed 's/\.//')"
    # Buscar archivos del mismo tipo que el archivo buscado
    #filesOfType=$(find "$USER_HOME" -type f -name "*.$fileType" 2>/dev/null)
    # Buscar el archivo específico dentro de la lista de archivos del mismo tipo
    #result=$(echo "$filesOfType" | grep "/$file$")

		#with locate command (more quickly)
	filesOfType=$(locate -ib $file)
    result=$(echo "$filesOfType" | grep "/$file$")

    # Verificar si se encontró el archivo antes de intentar ejecutarlo
    if [ -n "$result" ]; then
        bash "$result"
    else
        echo "El archivo \"$file\" no se encontró o no se puede leer."
    fi
}


cd /home/jordan/Scripts/DeInicio

clear

echo -e "

	Bienvenido Usuario ${ORANGE}$USER${NC} al centro de computos.

    	Usted tiene las siguientes opciones:

	${CYAN}0${NC} - ${ORANGE}Neofetch
	${CYAN}1${NC} - ${ORANGE}Apps
	${CYAN}2${NC} - ${ORANGE}Sistema
	${CYAN}3${NC} - ${ORANGE}Funcionalidades
	${CYAN}4${NC} - ${ORANGE}ABM Usuario
	${CYAN}5${NC} - ${ORANGE}ABM Grupo
	${CYAN}6${NC} - ${ORANGE}Red

	${CYAN}99${NC} - ${ORANGE}Salir${NC}
"

	read -rp "	Ingrese opción : " op

case $op in
	0)
	 clear
	 neofetch | lolcat
	 intro
	 bash /home/jordan/Scripts/DeInicio/Inicio.sh
	;;
	1)
	 findResource Apps.sh
	;;
	2)
	 findResource Sistema.sh
	;;
	3)
	 findResource Funcionalidades.sh
	;;
	4)
	 bash ./ABMs/ABM_usuario.sh
	;;
	5)
	 bash ./ABMs/ABM_grupo.sh
	;;
	6)
	 bash ./General/Red.sh
	;;
	99)
	 cd /home/jordan/
	 clear
	;;
	*)
	 clear
	 printf "	${RED}Error, por favor introduce una opción correcta.${NC}"
	 intro
	 bash Inicio.sh
	;;
esac
