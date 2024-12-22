#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' #no color

clear

init(){

	echo -e "
	${CYAN}Hi!!${NC}

	What script what do you want to start?

	${ORANGE}Neofetch.sh [n]${NC}
	${ORANGE}Init.sh (main script) [i]${NC}
	${ORANGE}No one (quit) [q]${NC}

		 "

	read -rp "	Enter option : " option

	case $option in
		"i" | "I")
		 clear
		 sh $HOME/Scripts/exeInit.sh
		 echo ""
		 clear
		;;
		"n" | "N")
	 	 clear
		 sh $HOME/Scripts/exeNeofetch.sh
		 echo ""
		 clear
		 init
		;;
		"q" | "Q")
		 clear
		 exit
		;;
		*)
		 sh $0
		;;
	esac

}


init
