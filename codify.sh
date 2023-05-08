#! /bin/bash

#Indicar el número total de subprocesos con los que cuenta la instancia donde se ejecutará el programa
numeroNucleos=2
listaFragmentados=listaArchivosFragmented.txt
procesoCodificacion=process.sh
rutaCodified=codified/
rutaLog=log/codified.log

#Si no existe la lista de archivos fragmentados finalizará la ejecución
if [[ ! -f $listaFragmentados ]]; then
	echo "ERROR. El archivo de lista de fragmentados no existe. Saliendo del programa."
	exit 2
fi

#Si el número de núcleos de la instancia donde se lanza el programa es < que la especificada finalizará la ejecución
if [[ $numeroNucleos > $(nproc --all) ]]; then
	echo "ERROR. El número de núcleos especificado en la variable <numeroNucleos> es superior al disponible. Saliendo del programa."
	exit 2
fi

#Codificamos los fragmentos de video en paralelo
echo "Codificando los fragmentos en paralelo..."
parallel --ungroup --jobs $numeroNucleos ./$procesoCodificacion :::: $listaFragmentados >>$rutaLog 2>&1
echo "Proceso de codificación completado."
echo "Creando lista de archivos codificados..."
for f in $rutaCodified*; do echo "file '$f'" >> listaArchivosCodified.txt; done
sort --version-sort --field-separator=\n -o listaArchivosCodified.txt listaArchivosCodified.txt
echo "Lista de archivos codificados creada."
