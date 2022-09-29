#! /bin/bash

rutaFragmented=fragmented/
rutaCodified=codified/
rutaLogs=log/
rutaGrouped=grouped/

echo "Limpiando listas ..."
rm lista*
echo "Limpiando fragmentos ..."
rm "$rutaFragmented"*
echo "Limpiando fragmentos codificados ..."
rm "$rutaCodified"*
echo "Limpiando logs ..."
rm "$rutaLogs"*
echo "Limpiando archivos concatenados ..."
rm "$rutaGrouped"*
echo "Limpieza finalizada"
