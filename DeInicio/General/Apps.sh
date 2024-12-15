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
	./$0 || findResource $0
}

intro(){
	read -rp "	<INTRO>"
}


clear

echo "
	Welcome User ${ORANGE}$USER${NC} select an app to launch from the Computing Center.

	Enter option:

	${CYAN}1${NC} - ${ORANGE}VSCode${NC}
	${CYAN}2${NC} - ${ORANGE}Chrome${NC}
    	${CYAN}3${NC} - ${ORANGE}System config (bspwm config file)${NC}
    	${CYAN}4${NC} - ${ORANGE}Bleachbit (sudo)${NC}
    	${CYAN}5${NC} - ${ORANGE}CPU-X${NC}
    	${CYAN}6${NC} - ${ORANGE}Joplin${NC}
    	${CYAN}7${NC} - ${ORANGE}Discord${NC}

	${RED}99${NC} - ${ORANGE}Back${NC}

	${RED}Q${NC} - ${ORANGE}Exit${NC}
"

read -rp "	Enter option : " op

case $op in
	1)
	 code
	 back
	;;
	2)
	 xdg-open https://google.com
	 back
	;;
	3)
	 sudo nano ~/.config/bspwm/bspwmrc
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
	 sh ../Init.sh || findResource Init.sh
	;;
	"Q" | "q")
	 clear
	 exit
	;;
	*)
	 clear
	 printf "	${RED}Error, please enter a valid option.${NC}"
	 intro
	 back
	;;
esac
