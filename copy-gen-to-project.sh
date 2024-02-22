#!/bin/bash

set -euo pipefail

frontend_dir="bmon-odds-react"
backend_dir="bmon-odds-server"
oddsgen_dir="bmon-odds-gen"

function fix_dupes(){
	local dir="$1"
	local ext="$2"

	#find any classes ending with a digit, these are duplicates by openapi-gen
	for file in $(find "$dir" -type f -regex ".*[0-9]$ext"); do
		dupeFileName=$(echo "$file" | grep -Po "\w+\d$ext")
		dupeClassName=$(echo "$dupeFileName" | grep -Po '\w+' | head -1)
		correctClassName=$(echo "$dupeClassName" | grep -Po '\D+' | head -1)

		#find any occurrences of the dupe classname and rename those
		for sourceFile in $(find "$dir" -type f); do 
			sed -i "s/$dupeClassName/$correctClassName/g" "${sourceFile}"
		done

		echo "Removed: $file"
		rm "$file"
	done
}

if [ -d "../${frontend_dir}" ] && [ -d "./out/typescript" ]; then
	rsync -rv "./out/typescript/." "../${frontend_dir}/src/openapi"
	echo "Updated frontend project with new openapi definitions"
fi

if [ -d "../${backend_dir}" ] && [ -d "./out/spring" ]; then
	fix_dupes "./out/spring" ".java"
	
	rsync -rv "./out/spring/." "../${backend_dir}/"
	echo "Updated backend project with new openapi definitions"
fi

if [ -d "../${oddsgen_dir}" ] && [ -d "./out/csharp" ]; then
	fix_dupes "./out/csharp" ".cs"

	rsync -rv "./out/csharp/." "../${oddsgen_dir}/"
	echo "Updated oddsgen project with new openapi definitions"
fi