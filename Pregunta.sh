#!/bin/bash

sleep 2

read -p "	<INTRO>"

read -p "	Quieres iniciar el script Inicio.sh [y/n]" eleccion
case $eleccion in
	y)
	bash /home/jordan/Scripts/DeInicio/Inicio.sh
	;;
	n)
	read -p "	<INTRO>"
	clear
	;;
	*)
	bash /home/jordan/Scripts/Pregunta.sh
	;;
esac
