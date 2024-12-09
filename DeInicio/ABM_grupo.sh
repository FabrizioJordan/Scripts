#!bin/bash

# grupos


listar_grupos() {
	clear
	echo "---- Lista de Grupos ----"
	awk -F: '{print $1}' /etc/group

	echo "
	$(date +%Y-%m-%d-%T) -> $USER : listó grupos : 
	" >> abmGrupoLog.txt
	awk -F: '{print $1}' /etc/group >> abmGrupoLog.txt
	echo "" >> abmUsuarioLog.txt
}

alta_grupo(){
	clear
	read -rp "Ingrese el nombre del nuevo grupo: " nuevo_grupo

	#verificamos si existe el grupo
	if getent group "$nuevo_grupo" &>/dev/null; then
		echo "El grupo ya existe."
		
		echo "
		$(date +%Y-%m-%d-%T) -> $USER : intentó crear un nuevo grupo llamado $nuevo_grupo, pero este ya existia
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt

	else
		groupadd "$nuevo_grupo"
		echo "Se ha creado el nuevo grupo"

		echo "
		$(date +%Y-%m-%d-%T) -> $USER : se creó un nuevo grupo llamado $nuevo_grupo 
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt

	fi

}

baja_grupo(){
	clear
	read -rp "Ingrese el nombre del grupo a eliminar: " grupo

	#verificamos si existe el grupo
 	if getent group "$grupo" &>/dev/null; then
		sudo groupdel "$grupo"
		echo "El grupo se ha eliminado."

		echo "
		$(date +%Y-%m-%d-%T) -> $USER : el grupo $grupo fue eliminado
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt

	else
		echo "El grupo no existe."
	
		echo "
		$(date +%Y-%m-%d-%T) -> $USER : El grupo $grupo no existe
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt 	

	fi

}


modificar_grupo() {
	clear
	read -rp "Ingrese el nombre del grupo a modificar: " grupo

	#verificamos si existe el grupo
 	
	if getent group "$grupo" &>/dev/null; then
		
		read -rp "Ingrese el nuevo GID de $grupo: " gid
		sudo groupmod -g "$gid" "$grupo"

		echo "
		$(date +%Y-%m-%d-%T) -> $USER : modificando el grupo $grupo se le cambio el GID a $gid
		" >> abmGrupoLog.txt	
		echo "" >> abmGrupoLog.txt

		read -rp "Ingrese el nuevo nombre a $grupo: " nuevo_nombre_grupo
		sudo groupmod -n "$nuevo_nombre_grupo" "$grupo"
		echo "Se ha cambiado el nombre del grupo $grupo al nombre $nuevo_nombre_grupo con el nuevo GID de $gid."
	
		echo "
		$(date +%Y-%m-%d-%T) -> $USER : Se ha cambiado el nombre del grupo $grupo a $nuevo_nombre_grupo
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt	

	else
		echo "El grupo no existe."
		
		echo "
		$(date +%Y-%m-%d-%T) -> $USER : intentó modificar el grupo $grupo , pero este no exsitía
		" >> abmGrupoLog.txt
		echo "" >> abmGrupoLog.txt

	fi

}


echo "
Bienvenido Usuario $USER al ABM de grupos.

Usted tiene las siguientes opciones 

1- Altas
2- Bajas
3- Modificaciones
4- Listado
99- Volver
"

read -p "Ingrese opcion : " op

case $op in
	1)	# crear grupo
	clear
	alta_grupo
	read -p "<INTRO>"
	sh ABM_grupo.sh
	;;
	2)	# borrar grupo
	clear
	baja_grupo
	read -p "<INTRO>"
	sh ABM_grupo.sh
	;;
	3)	# modificar grupo
	clear
	modificar_grupo
	read -p "<INTRO>"
	sh ABM_grupo.sh
	;;
	4)	# listar grupos
	clear
	listar_grupos
	read -p "<INTRO>"
	sh ABM_grupo.sh
	;;
	99)	# volver
	clear
	sh Inicio.sh
	;;
	*)
	echo "Error"
	read -p "<INTRO>"
	sh Inicio.sh
	;;
esac
