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

iniciarScript(){
	bash Red.sh
}

pingear(){
	read -rp "Introduzca ip o dirección a pingear: " ip
	ping $ip
}

curlDir(){
	read -rp "Introduzca la direccion para hacerle curl: " direccion
	curl $direccion
}

verInterfaces(){
	netstat -i
}

verNetstat(){
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


			# Inicia

clear


echo -e "

	Bienvenido Usuario ${ORANGE}$USER${NC} al Centro de Computos de Red.

    	Usted tiene las siguientes opciones:

	${CYAN}1${NC} - ${ORANGE}Ping${NC}
	${CYAN}2${NC} - ${ORANGE}Curl${NC}
    	${CYAN}3${NC} - ${ORANGE}Ver interfaces de red${NC}
    	${CYAN}4${NC} - ${ORANGE}Ver Netstat${NC}
	${CYAN}5${NC} - ${ORANGE}Ver Netstat (established connections)${NC}
	${CYAN}6${NC} - ${ORANGE}Ver route (tabla de enrutamiento)${NC}

	${CYAN}99${NC} - ${ORANGE}Volver${NC}
"

read -rp "	Ingrese la opcion : " op

case $op in
	1) # pingear
	clear
	pingear
	intro
	iniciarScript
	;;
	2) # curl
	clear
	curlDir
	intro
	iniciarScript
	;;
	3) # ver interfaces de red
	clear
	verInterfaces
	intro
	iniciarScript
	;;
	4) # ver netstat
	clear
	verNetstat
	intro
	iniciarScript
	;;
	5) # ver netstat con Established
	clear
	netEstablished
	intro
	iniciarScript
	;;
	6) # ver route
	clear
	seeRoute
	intro
	iniciarScript
	;;
	99) # volver
	clear
	bash ./Init.sh
	;;
	*)
	clear
	printf "	${RED}Error, por favor introduce una opción correcta.${NC}"
	intro
	bash ../Init.sh
	;;
esac

