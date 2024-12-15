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
        echo "	The file \"$file\" was not found or could not be read."
    fi
}


cd $HOME/Scripts/DeInicio

clear

echo "

	Welcome User ${ORANGE}$USER${NC} to the computing center.

		You have the following options:

	${CYAN}0${NC} - ${ORANGE}Neofetch
	${CYAN}1${NC} - ${ORANGE}Apps
	${CYAN}2${NC} - ${ORANGE}System
	${CYAN}3${NC} - ${ORANGE}Funcionalities
	${CYAN}4${NC} - ${ORANGE}ABM User
	${CYAN}5${NC} - ${ORANGE}ABM Group
	${CYAN}6${NC} - ${ORANGE}Network

	${RED}99${NC} - ${ORANGE}Back${NC}

	${RED}Q${NC} - ${ORANGE}Exit${NC}
"

	read -rp "	Enter option : " op

case $op in
	0)
	 clear
	 ../exeNeofetch.sh
	 intro
	 bash $HOME/Scripts/DeInicio/Init.sh
	;;
	1)
	 findResource Apps.sh
	;;
	2)
	 findResource System.sh
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
	 cd $HOME
	 clear
	;;
	Q)
	 clear
	 exit
	;;
	*)
	 clear
	 printf "	${RED}Error, please enter a valid option.${NC}"
	 intro
	 bash Init.sh
	;;
esac
