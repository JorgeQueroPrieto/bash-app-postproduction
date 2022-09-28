#! /bin/bash

listaCodificados=listaArchivosCodified.txt
rutaCodified=codified/
rutaGrouped=grouped/
rutaLog=log/group.log

#Si no existe la lista de archivos codificados finalizará la ejecución
if [[ ! -f $listaCodificados ]]; then
	echo "ERROR. El archivo de lista de codificados no existe. Saliendo del programa."
	exit 2
fi

#Extraemos la extensión de salida del archivo de codified/0.*
for f in codified/0.* 
do
	extension="${f##*.}" 
done

#Agrupamos los fragmentos del video
ffmpeg -f concat -i $listaCodificados -c copy "grouped/output.$extension" >>$rutaLog 2>&1
echo "Proceso de agrupación completado. El archivo " $1 " ha sido almacenado en " $rutaGrouped
