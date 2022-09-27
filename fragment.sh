#! /bin/bash

rutaPristine=camera/
rutaFragmented=fragmented/
rutaLog=log/fragmented.log

#Si no se provee de ningún argumento finalizará la ejecución
if [[ $# -ne 1 ]]; then
	echo "ERROR. No se ha indicado ningún archivo de entrada para la fragmentación, saliendo del programa."
	exit 2	
else
	if [[ ! -f $rutaPristine$1 ]]; then
		echo "ERROR. El archivo introducido como argumento no existe. Saliendo del programa."
		exit 2
	fi
fi

#Obtenemos la duración y extensión del video original
extension=$(echo "$1" | sed 's/.*\.//')
duracionPristine=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $rutaPristine$1)

#Calculamos en horas, minutos y segundos la duración del video
duracionHorasPristine=$(bc <<< "scale=0; $duracionPristine / 3600")
duracionMinutosPristine=$(bc <<< "scale=0; $duracionPristine % 3600 / 60")
duracionSegundosPristine=$(bc <<< "scale=0; $duracionPristine % 60" | awk 'gsub(/\./,",")||1' | awk '{print int($0)}')

echo "El pristine " $1 " tiene una duración de " $duracionHorasPristine " h " $duracionMinutosPristine " m " $duracionSegundosPristine " s" 

#Procedemos a la fragmentación del vídeo en frag. de 30s
numFragmentos=$(bc <<< "scale=0; $duracionPristine / 30")
echo "Fragmentando el vídeo " $1 " en " $numFragmentos " fragmentos de 30s en la ruta " $rutaFragmented 
tiempoInicialRecorte=0
i=0
while [[ $i -lt $numFragmentos ]]; do 
	if [ $i -eq $(($numFragmentos-1)) ]; then
		ffmpeg -i $rutaPristine$1 -ss $tiempoInicialRecorte -to $duracionPristine -c:v copy -c:a copy "$rutaFragmented$i.$extension" >>$rutaLog 2>&1	
	else
		ffmpeg -i $rutaPristine$1 -ss $tiempoInicialRecorte -t 30 -c:v copy -c:a copy "$rutaFragmented$i.$extension" >>$rutaLog 2>&1
	fi
	(( i += 1 ))
	(( tiempoInicialRecorte += 30 ))
done
echo "Fragmentación completa."

#Creación de la lista de archivos fragmentados
ls $rutaFragmented >> listaArchivosFragmented.txt;
