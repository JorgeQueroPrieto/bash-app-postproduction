#!/bin/bash

rutaPristine=camera/
rutaFragmented=fragmented/
rutaCodified=codified/
rutaGrouped=grouped/

#Obtenemos la duración del video original
duracionPristine=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $rutaPristine$1)

#Calculamos en horas, minutos y segundos la duración del video
duracionHorasPristine=$(bc <<< "scale=0; $duracionPristine / 3600")
duracionMinutosPristine=$(bc <<< "scale=0; $duracionPristine % 3600 / 60")
duracionSegundosPristine=$(bc <<< "scale=0; $duracionPristine % 60" | awk 'gsub(/\./,",")||1' | awk '{print int($0)}')

echo "El pristine " $1 " tiene una duración de " $duracionHorasPristine " h " $duracionMinutosPristine " m " $duracionSegundosPristine " s" 

#Procedemos a la fragmentación del vídeo en frag. de 30s
numFragmentos=$(bc <<< "scale=0; $duracionPristine / 30")
echo "Fragmentando el vídeo " $1 " en " $numFragmentos " fragmentos de 30s en la ruta " $rutaFragmented 
tiempoIncialRecorte=0
indiceFragmento=0
for $indiceFragmento in $numFragmentos 
do
	if []; then
		echo "Fragmento " $indiceFragmento + 1
	else
		echo "Último fragmento " $indiceFragmento + 1
	fi
done
