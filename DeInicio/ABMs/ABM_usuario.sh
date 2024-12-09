#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # no color


findResource() {
    local file="$1"
	local USER_HOME="$HOME"

    local fileType="$(echo "$file" | grep -oE '\.[^.]+$' | sed 's/\.//')"
    # Buscar archivos del mismo tipo que el archivo buscado
    filesOfType=$(find "$USER_HOME" -type f -name "*.$fileType" 2>/dev/null)
    # Buscar el archivo específico dentro de la lista de archivos del mismo tipo
    result=$(echo "$filesOfType" | grep "/$file$")
    # Verificar si se encontró el archivo antes de intentar ejecutarlo
    if [ -n "$result" ]; then
        bash "$result"
    else
        echo "El archivo \"$file\" no se encontró o no se puede leer."
    fi
}



clear

# usuarios

#listar_usuarios() {
#	clear
#	echo "---- Lista de Usuarios ----"
#	printf "%-20s %-10s $-10s\n" "Nombre de Usuario" "UID" "Directorio de Trabajo"
#	awk -F: '{printF "%-20s %-10s %-10s\n", $1, $3, $6}' /etc/passwd
#}

intro(){
	read -rp "	<INTRO>"
}


listar_usuarios() {
	clear
	echo "---- Lista de Usuarios ----"
	awk -F: '{print $1}' /etc/passwd
	echo " $(date +%Y-%m-%d-%T) -> $USER : listó usuarios: " >> abmUsuarioLog.txt
	awk -F: '{print $1}' /etc/passwd >> abmUsuarioLog.txt
}

alta_usuario() {
	clear
	read -rp "	Ingrese el nombre del nuevo usuario: " nuevo_usuario

	#verificamos si existe el usuario
	if id "$nuevo_usuario" &>/dev/null; then
		echo "	El usuario $nuevo_usuario ya existe."

		echo "
		$(date +%Y-%m-%d-%T) -> $USER : intentó crear un nuevo usuario pero este ya existía, el nombre es: $nuevo_usuario
		" >> abmUsuarioLog.txt
	else
		sudo useradd "$nuevo_usuario"
		echo "	El usuario $nuevo_usuario ha sido creado."

		echo "
		$(date +%Y-%m-%d-%T) -> $USER : creó un nuevo usuario llamado $nuevo_usuario 
		" >> abmUsuarioLog.txt

		read -rp "	Ingrese el nombre del grupo para el usuario: " grupo

		#verificamos si existe el grupo
		if getent group "$grupo" &>/dev/null; then
			usermod -g "$grupo" "$nuevo_usuario"
			echo "	Se ha modificado el usuario introduciendolo al grupo"

			echo "
			$(date +%Y-%m-%d-%T) -> $USER : modificó el usuario $nuevo_usuario introduciendolo al grupo $grupo
			" >> abmUsuarioLog.txt
		else
			groupadd "$grupo"
			usermod -g "$grupo" "$nuevo_usuario"
			echo "	Se ha creado el grupo e introducido el usuario al grupo" 

			echo "
			$(date +%Y-%m-%d-%T) -> $USER : se creó el grupo $grupo y se introdujo al usuario $nuevo_usuario al grupo
			" >> abmUsuarioLog.txt

		fi

	fi
}

baja_usuario() {
	clear
	read -rp "	Ingrese el nombre de usuario que desea eliminar: " usuario

	#verificamos si existe
	if sudo id "$usuario" &>/dev/null; then
		sudo userdel --remove -f "$usuario"
		echo "	El usuario $usuario ha sido eliminado."

		echo "
		$(date +%Y-%m-%d-%T) -> $USER: el usuario $usuario fue eliminado.
		" >> abmUsuarioLog.txt

	else
		echo "	El usuario $usuario no existe."

		echo "
		$(date +%Y-%m-%d-%T) -> $USER : intentó borrar el usuario $usuario pero este no existe.
		" >> abmUsuarioLog.txt

	fi
}

modificar_usuario() {
	clear
	read -rp "	Ingrese el nombre del usuario a modificar :  " usuario

	#verificamos si existe
	if id "$usuario" &>/dev/null; then
		read -rp "	Ingrese el nuevo nombre de usuario: " nuevo_nombre

			if id "$nuevo_nombre" &>/dev/null;then
				echo "	El nombre de usuario $nuevo_nombre ya existe."

				echo "
				$(date +%Y-%m-%d-%T) -> $USER : modificando el usuario $usuario este ya existia.
				" >> abmUsuarioLog.txt

			else
				sudo usermod -l "$nuevo_nombre" "$usuario"
				echo "	El usuario $usuario ha sido modificado a $nuevo_nombre."

				echo "
				$(date +%Y-%m-%d-%T) -> $USER : se modificó el usuario $usuario para tener el nombre de $nuevo_nombre .
				" >> abmUsuarioLog.txt

			fi
	else
		echo "	El usuario $usuario no existe."

		echo "
		$(date +%Y-%m-%d-%T) -> $USER : intentando modificar el usuario $usuario , este no existia.
		" >> abmUsuarioLog.txt

	fi
}


echo -e "
	Bienvenido Usuario ${ORANGE}$USER${NC} al ABM de usuarios.

	Usted tiene las siguientes opciones:

	${CYAN}1${NC} - ${ORANGE}Altas${NC}
	${CYAN}2${NC} - ${ORANGE}Bajas${NC}
	${CYAN}3${NC} - ${ORANGE}Modificación${NC}
	${CYAN}4${NC} - ${ORANGE}Listado${NC}

	${CYAN}99${NC} - ${ORANGE}Volver${NC}
"
read -rp "	Ingrese opcion : " op

case $op in
	1)	# alta usuario
	 clear
	 alta_usuario
	 intro
	 bash ABM_usuario.sh
	;;
	2)	# baja usuario
	 clear
	 baja_usuario
	 intro
	 bash ABM_usuario.sh
	;;
	3)	# modificar usuario
	 clear
	 modificar_usuario
	 intro
	 bash ABM_usuario.sh
	;;
	4)	# listar usuarios
	 clear
	 listar_usuarios
	 intro
	 bash ABM_usuario.sh
	;;
	99)
	 clear
	 bash Init.sh
	;;
	*)
	 clear
	 printf "	${RED}Error, por favor introduce una opción correcta.${NC}"
	 intro
	 bash Init.sh
	;;
    esac
