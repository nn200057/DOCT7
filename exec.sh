#!/bin/bash


find . -name "Result.html" -type f -delete
rm -rf TempResult
mkdir TempResult


fichiers=`ls ./MutadedSrc/`
i=1;
for fichier in $fichiers
do
	echo -n "Build all $fichier .."
	cd "./MutadedSrc/$fichier/"
	# bash build_all.sh &> /dev/null 
	cd ../..
	cp -Rf "./MutadedSrc/$fichier/j2e/target/surefire-reports/" ./TempResult/
	mkdir ./TempResult/surefire-reports-$i/
	mv -f ./TempResult/surefire-reports/* ./TempResult/surefire-reports-$i/
	i=$((i + 1))
	echo ".Done"
done


rm -rf ./TempResult/surefire-reports
find ./TempResult -name "*.txt" -type f -delete

dossier="$(pwd)/TempResult/"

cd "./XmlsCompiler/out/artifacts/XmlsCompiler_jar/"
java -jar XmlsCompiler.jar "$dossier"

mv Result.html ../../../../
