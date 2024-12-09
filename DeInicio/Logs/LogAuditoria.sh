#!/bin/bash

# debemos listar los logs

# tipos de logs:

#	ABM_usuario.sh
#	ABM_grupo.sh


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



verLogs() {
	clear
	cat verLogsAuditoria.txt
}

abmUsuario() {
	clear
	echo "
	---- Logs de ABM_usuario ----"
	echo "---- 63??¿¿36 ----"
	cat abmUsuarioLog.txt
}

abmGrupo() {
	clear
	echo "---- Logs de ABM_grupo ----"
	echo "---- *W,4.4,W* ----"
	cat abmGrupoLog.txt
}


# Inicio

	
			# Inicia

echo "

Bienvenido $USER al menú de logs de auditoría.

Usted tiene las siguientes opciones:

1- Ver tipos de logs

Logs:
	2- ABM_Usuario
	3- ABM_Grupo

99- Volver
"

read -p "Ingrese opción : " op

case $op in
	1) # ver tipos de logs
		clear
		verLogs
		read -p "<INTRO>"
		sh LogAuditoria.sh
	;;
	2) # ABM_Usuario
		clear
		abmUsuario
		read -p "<INTRO>"
		sh LogAuditoria.sh
	;;
	3) # ABM_Grupo
		clear
		abmGrupo
		read -p "<INTRO>"
		sh LogAuditoria.sh
	;;
	99) # Volver
		clear
		sh Init.sh
	;;
	*)
		echo "Error"
	;;
esac
