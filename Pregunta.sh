#!/bin/bash

echo ""

read -p "	Do you want to start the script Neofetch.sh [y/n] " option
case $option in
	y)
	 clear

	 bash $HOME/Scripts/exeNeofetch.sh
	
	 echo ""
	
	 bash $HOME/Scripts/exeInit.sh

	clear
	;;
	n)
	clear
	 bash $HOME/Scripts/exeInit.sh
	clear
	;;
	*)
	bash $HOME/Scripts/Pregunta.sh
	;;
esac