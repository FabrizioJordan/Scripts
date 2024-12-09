
#!bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # no color


# groups


list_groups() {
	clear
	echo "---- Lista de Grupos ----"
	awk -F: '{print $1}' /etc/group

	echo "
	$(date +%Y-%m-%d-%T) -> $USER : listó grupos : 
	" >> abmGrupoLog.txt
	awk -F: '{print $1}' /etc/group >> abmGrupoLog.txt
	echo "" >> abmUsuarioLog.txt
}

create_group(){
	clear
	read -rp "Ingrese el nombre del nuevo grupo: " nuevo_grupo

	# verify if the group exists
	if getent group "$nuevo_grupo" &>/dev/null; then
		echo "The group already exists."
		
		echo "
		$(date +%Y-%m-%d-%T) -> $USER : tried to create a new group called $nuevo_grupo, but it already exists
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt

	else
		groupadd "$nuevo_grupo"
		echo "The new group has been created"

		echo "
		$(date +%Y-%m-%d-%T) -> $USER : a new group called $nuevo_grupo has been created
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt

	fi

}

delete_group(){
	clear
	read -rp "Enter the name of the group to delete: " grupo

	# verify if the group exists
 	if getent group "$grupo" &>/dev/null; then
		sudo groupdel "$grupo"
		echo "The group $grupo has been deleted."

		echo "
		$(date +%Y-%m-%d-%T) -> $USER : the group $grupo has been deleted
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt

	else
		echo "The group does not exist."
	
		echo "
		$(date +%Y-%m-%d-%T) -> $USER : The group $grupo does not exist
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt 	

	fi

}


modify_group() {
	clear
	read -rp "Enter the name of the group to modify: " grupo

	# verify if the group exists
 	
	if getent group "$grupo" &>/dev/null; then
		
		read -rp "Ingrese el nuevo GID de $grupo: " gid
		sudo groupmod -g "$gid" "$grupo"

		echo "
		$(date +%Y-%m-%d-%T) -> $USER : modifying the group $grupo, the GID has been changed to $gid
		" >> abmGrupoLog.txt	
		echo "" >> abmGrupoLog.txt

		read -rp "Enter the new name for $grupo: " nuevo_nombre_grupo
		sudo groupmod -n "$nuevo_nombre_grupo" "$grupo"
		echo "The name of the group $grupo has been changed to $nuevo_nombre_grupo with the new GID of $gid."
	
		echo "
		$(date +%Y-%m-%d-%T) -> $USER : the name of the group $grupo has been changed to $nuevo_nombre_grupo
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt	

	else
		echo "The group does not exist."
		
		echo "
		$(date +%Y-%m-%d-%T) -> $USER : tried to modify the group $grupo, but it does not exist
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt

	fi

}

clear

#Start Menu

echo -e "
    Welcome User ${ORANGE}$USER${NC} to the ABM of groups.

    You have the following options:

    ${CYAN}1${NC} - ${ORANGE}Create
    ${CYAN}2${NC} - ${ORANGE}Delete
    ${CYAN}3${NC} - ${ORANGE}Modify
    ${CYAN}4${NC} - ${ORANGE}List

    ${CYAN}99${NC} - ${ORANGE}Back${NC}

    ${RED}Z${NC} - ${ORANGE}Exit${NC}
"

read -p "   Enter the option : " op

case $op in
	1)	# create group
	 clear
	 create_group
	 read -p "<INTRO>"
	 sh ABM_grupo.sh
	;;
	2)	# delete group
	 clear
	 delete_group
	 read -p "<INTRO>"
	 sh ABM_grupo.sh
	;;
	3)	# modify group
	 clear
	 modify_group
	 read -p "<INTRO>"
	 sh ABM_grupo.sh
	;;
	4)	# list groups
	 clear
	 list_groups
	 read -p "<INTRO>"
	 sh ABM_grupo.sh
	;;
	99)	# back
	 clear
	 sh Init.sh
	;;
	Z)	# exit
	 clear
	 exit
	;;
	*)
	 echo -e "${RED}Error${NC} : Invalid option"
	 read -p "<INTRO>"
	 sh ABM_grupo.sh
	;;
esac


