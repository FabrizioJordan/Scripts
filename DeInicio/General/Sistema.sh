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

    filesOfType=$(locate -ib $file)
    result=$(echo "$filesOfType" | grep "/$file$")
    # Verificar si se encontró el archivo antes de intentar ejecutarlo
    if [ -n "$result" ]; then
        bash "$result"
    else
        echo "	El archivo \"$file\" no se encontró o no se puede leer."
    fi
}

back(){
	findResource Sistema.sh
}


intro(){
	read -rp "		<INTRO>"
}


clear

echo -e "
	Bienvenido usuario ${ORANGE}$USER${NC} a la modificación del sistema del Centro de Cómputos.

	Ingrese Opción:

	${CYAN}1${NC} - ${ORANGE}Update System (smart way)${NC}
	${CYAN}2${NC} - ${ORANGE}Delete Obsolete Files (autoremove)${NC}
	${CYAN}3${NC} - ${ORANGE}Clean Old Configs & Caché (purge and clean)${NC}
	${CYAN}4${NC} - ${ORANGE}See all of the apt packages installed${NC}
	${CYAN}5${NC} - ${ORANGE}See all of the flatpak packages installed${NC}
	${CYAN}6${NC} - ${ORANGE}Show the info of this package in apt${NC}
	${CYAN}7${NC} - ${ORANGE}See all of tages installed${NC}
	${CYAN}8${NC} - ${ORANGE}Desplays disk usage of files and dirs in print${NC}
	${CYAN}9${NC} - ${ORANGE}Desplays visual disk usage of User dir${NC}
	${CYAN}10${NC} - ${ORANGE}Lists information about all available or specified block devices${NC}



	${CYAN}99${NC} - ${ORANGE}Volver${NC}
"

read -rp "	Ingrese opcion : " op

case $op in
	1)
	 sudo apt-get dist-upgrade
	 back
	;;
	2)
	 sudo apt autoremove
	 back
	;;
	3)
	 sudo apt purge & sudo apt clean
	 back
	;;
	4)
	 sudo apt list --installed | batcat
	 intro
	 back
	;;
	5)
	 sudo flatpak list | batcat
	 intro
	 back
	;;
	6)
	 clear
	 read -p $'\e[0;32m		What package App you want to show?\e[0m' app

	 if [ $app != " " ] || [ $app != "" ];then
	 	sudo apt show $app 2>/dev/null | batcat
	 else
	 	echo -e "${RED} 	Error, the following packages are not found: ${app} ${NC}"
	 fi

	 intro
	 back
	;;
	7)
	 sudo flatpak list | batcat
	 intro
	 back
	;;
	8)
	 du -ah --time-style=long-iso
	 intro
	 back
	;;
	9)
	 ncdu -xe --exclude-caches --exclude-caches --color=dark /home/jordan
	 intro
	 back
	;;
	10)
	 lsblk -l
	 intro
	 back
	;;
	99)
	 clear
	 findResource Inicio.sh
	;;
	*)
	 clear
	 printf "	${RED}Error, por favor introduce una opción correcta.${NC}"
	 intro
	 back
	;;
esac
