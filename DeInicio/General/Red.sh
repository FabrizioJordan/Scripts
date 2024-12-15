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

    #local fileType="$(echo "$file" | grep -oE '\.[^.]+$' | sed 's/\.//')"
    # Buscar archivos del mismo tipo que el archivo buscado
    #filesOfType=$(find "$USER_HOME" -type f -name "*.$fileType" 2>/dev/null)
    # Buscar el archivo específico dentro de la lista de archivos del mismo tipo
    #result=$(echo "$filesOfType" | grep "/$file$")

		# with locate command (fast way)
	filesOfType=$(locate -ib $file)
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

initCurrentScript(){
	sh Red.sh || findResource Red.sh
}

pingFunc(){
	read -rp "	Enter IP or address to ping : " ip
	ping $ip
}

curlDir(){
	read -rp "	Enter the address to curl : " direction
	curl $direction
}

interfaces(){
	netstat -i
}

seeNetstat(){
	netstat -natu
}

netEstablished(){
	netstat -natu | grep 'ESTABLECIDO'
}

seeRoute(){
	route -n
}




#

# Inicio

clear


echo "

	Welcome User ${ORANGE}$USER${NC} to the Network Computing Center.

    	You have the following options:

	${CYAN}1${NC} - ${ORANGE}Ping${NC}
	${CYAN}2${NC} - ${ORANGE}Curl${NC}
    	${CYAN}3${NC} - ${ORANGE}See network interfaces${NC}
    	${CYAN}4${NC} - ${ORANGE}See Netstat${NC}
	${CYAN}5${NC} - ${ORANGE}See Netstat (established connections)${NC}
	${CYAN}6${NC} - ${ORANGE}See route (routing table)${NC}

	${RED}99${NC} - ${ORANGE}Back${NC}

	${RED}Q${NC} - ${ORANGE}Exit${NC}

"

read -rp "	Enter option : " op

case $op in
	1) # pinging
	clear
	pingFunc
	intro
	initCurrentScript
	;;
	2) # curl
	clear
	curlDir
	intro
	initCurrentScript
	;;
	3) # ver interfaces de red
	clear
	interfaces
	intro
	initCurrentScript
	;;
	4) # ver netstat
	clear
	seeNetstat
	intro
	initCurrentScript
	;;
	5) # ver netstat con Established
	clear
	netEstablished
	intro
	initCurrentScript
	;;
	6) # ver route
	clear
	seeRoute
	intro
	initCurrentScript
	;;
	99) # volver
	clear
	bash ./Init.sh || findResource Init.sh
	;;
	*)
	clear
	printf "	${RED}Error, please enter a valid option.${NC}"
	intro
	bash ../Init.sh || findResource Init.sh
	;;
esac

