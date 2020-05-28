# convert multi page TIF files to jpeg
for file in $(find . -type f -name "*.TIF" -print0) 
do
	echo $file
done
