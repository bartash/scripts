# convert multi page TIF files to jpeg

# file names have spaces
find . -name '*.TIF' -print0 | while read -d $'\0' file
do 
	newfile=$(echo "$file" | sed 's/TIF/jpg/')
	convert "$file" "$newfile"
	
done
