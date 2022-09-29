#! /bin/bash
pristine=pristine.mp4

if [[ ! -f camera/$pristine ]]; then
	echo "ERROR. No existe la carpeta camera, o el archivo a codificar." 
	if [[ ! -d camera ]]; then 
		mkdir camera
	fi
	echo "Porfavor, copie el archivo a codificar en la carpeta camera. Finalizando programa."
	exit 2
fi
if [[ ! -d fragmented ]]; then
	mkdir fragmented
fi
if [[ ! -d codified ]]; then
	mkdir codified
fi
if [[ ! -d grouped ]]; then
	mkdir grouped
fi
if [[ ! -d log ]]; then
	mkdir log
fi

./clear.sh
./fragment.sh $pristine
./codify.sh
./group.sh
