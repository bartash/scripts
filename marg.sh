cd  ~/Margolies
for page in `seq 1 586`;
do
	curl "https://www.loc.gov/pictures/search/?q=mrg&sp=$page" > $page.html
	echo did $page
	sleep 1
done    
        
