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
	i)
	 clear
	 bash $HOME/Scripts/exeInit.sh
	 echo ""
	 clear
	;;
	n)
 	 clear
	 bash $HOME/Scripts/exeNeofetch.sh
	 echo ""
	 clear
	;;
	q)
	 clear
	 exit
	;;
	*)
	 bash $HOME/Scripts/Pregunta.sh
	;;
esac
