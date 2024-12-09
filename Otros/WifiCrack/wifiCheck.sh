#!/bin/bash


#dejé el video en el min 30

# Author: FabricioJordán


#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
orangeColour="\e[0;33\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#NewLine
#\n
#Tabulator
#\t

trap ctrl_c INT

function ctrl_c(){
	echo "Saliendo"
}

function helpPanel(){
	echo -e "\n${orangeColour} Bienvenido al Panel de Ayuda ${endColour}\n"
	echo -e "${yellowColour}[*]${endColour}${grayColour} Uso: ./wifiCheck.sh${endColour}"
	echo -e "\n\t${purpleColour}a)${endColour}${yellowColour} Modo de ataque${endColour}"
	echo -e "\t\t${redColour}Handshake${endColour}"
	echo -e "\t\t${redColour}PKMID${endColour}"
	echo -e "\t${purpleColour}n)${endColour}${yellowColour} Nombre de la tarjeta de red${endColour}"
	echo -e "\t${purpleColour}h)${endColour}${yellowColour} Mostrar este panel de ayuda${endColour}\n"
	exit 0
}

function startAttack(){
	echo "Empezando ataque (attack_mode=$attack_mode || networkCard=$networkCard)"
}



# Main Function

if [ "$(id -u)" == 0 ]; then
	declare -i parameter_counter=0; while getopts ":a:n:h:" arg; do
		case $arg in
			a) attack_mode=$OPTARG; let parameter_counter+=1
			;;
			n) networkCard=$OPTARG; let parameter_counter+=1
			;;
			h) helPanel;;
		esac
	done

	if [ $parameter_counter -ne 2 ]; then
		helpPanel
	else
		
		startAttack
	fi
else
	echo -e "\n${redColour}[+] No soy root${endColour}\n"
fi


