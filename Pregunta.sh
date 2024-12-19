#!/bin/bash
clear

echo "
	 What script what do you want to start?
	 Neofetch.sh [n]
	 Init.sh [i] (init starts the main script)
	 No one (Quit) [q]

	 "

read -rp "	 Enter option : " option

case $option in
	"i" | "I")
	 clear
	 bash $HOME/Scripts/exeInit.sh
	 echo ""
	 clear
	;;
	"n" | "N")
 	 clear
	 bash $HOME/Scripts/exeNeofetch.sh
	 echo ""
	 clear
	;;
	"q" | "Q")
	 clear
	 exit
	;;
	*)
	 bash $HOME/Scripts/Pregunta.sh
	;;
esac
