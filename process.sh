#! /bin/bash

extensionEntrada=mp4
codec=copy
extensionSalida=mkv
bitrate=24
rutaFragmented=fragmented/
rutaCodified=codified/
nombreArchivo=$(echo "$1" | sed 's/\.[^.]*$//')
extensionEntradaReal=$(echo "$1" | sed 's/.*\.//')

#Si la extensión de entrada especificada no coincide con la real del archivo, finalizará el programa.
if [[ $extensionEntrada -ne $extensionEntradaReal ]]; then
	echo "ERROR. El formato de entrada de video especificado no coincide con el formato del video introducido, saliendo del programa."
	exit 2	
fi

echo "Procediendo a codificar el fragmento " $1
ffmpeg -i $rutaFragmented$1 -c $codec "$rutaCodified$nombreArchivo.$extensionSalida"
