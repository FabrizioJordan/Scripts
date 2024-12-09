#!/bin/bash

# Imprimir mucho texto
for i in {1..50}; do
    echo "Borrando líneas. Espere..."
    sleep 0.01  # Pequeño retraso para simular la impresión gradual
done

# Esperar un momento antes de limpiar la pantalla
sleep 1

# Desplazar la pantalla hacia arriba
printf "\033[2J"  # Borra la pantalla
printf "\033[H"   # Mueve el cursor al inicio de la pantalla

# Imprimir un mensaje después de desplazar la pantalla
echo "Parte del texto anterior permanece visible."

