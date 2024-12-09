#!bin/bash

read -p "	Do you want to start the script Init.sh [y/n] " option
	
	 case $option in
		y)
		bash $HOME/Scripts/DeInicio/Init.sh
		;;
		n)
		clear
		;;
		*)
		clear
		;;
	 esac