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
duracionPristine=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$rutaPristine$1")

#Calculamos en horas, minutos y segundos la duración del video
duracionHorasPristine=$(bc <<< "scale=0; $duracionPristine / 3600")
duracionMinutosPristine=$(bc <<< "scale=0; $duracionPristine % 3600 / 60")
duracionSegundosPristine=$(bc <<< "scale=0; $duracionPristine % 60" | awk 'gsub(/\./,",")||1' | awk '{print int($0)}')

echo "El pristine " $1 " tiene una duración de " $duracionHorasPristine " h " $duracionMinutosPristine " m " $duracionSegundosPristine " s, y una duración total de " $duracionPristine " s" 

#Procedemos a la fragmentación del vídeo en frag. de 30s
echo "Fragmentando el vídeo " $1 " en fragmentos de 30s en la ruta " $rutaFragmented 

tiempoInicialRecorte=$(bc <<< "0")
i=0
while [[ $(echo "$tiempoInicialRecorte < $duracionPristine" | bc -l) -eq 1 ]]; do 
	if [[ $(echo "$duracionPristine - $tiempoInicialRecorte < 30" | bc -l) -eq 1  ]]; then
		ffmpeg -ss "$tiempoInicialRecorte" -i "$rutaPristine$1" -c:v copy -c:a copy -to "$duracionPristine" "$rutaFragmented$i.$extension" >>"$rutaLog" 2>&1
		tiempoInicialRecorte=$duracionPristine
	else
		ffmpeg -ss "$tiempoInicialRecorte" -i "$rutaPristine$1" -c:v copy -c:a copy -t 30 "$rutaFragmented$i.$extension" >>"$rutaLog" 2>&1
		tiempoInicialRecorte=$(bc <<< "scale=6; $tiempoInicialRecorte + $(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$rutaFragmented$i.$extension")") 
		(( i+=1 ))
	fi
done
echo "Fragmentación completa."
echo "Creando lista de archivos fragmentados ..."
#Creación de la lista de archivos fragmentados
ls $rutaFragmented >> listaArchivosFragmented.txt;
echo "Lista de archivos fragmentados creada."
