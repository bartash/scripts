#
echo "Here is a document called 'Six Seasons in Sartar' that I want to ask you questions about"
echo "I will paste it in 19 parts, so just wait until I write 'END' to show that I have finished pasting"
read -p "paste into window, then press enter to continue"
for i in Six_Split_a? 
do 
	echo $i
	cat $i | clip.exe
       	read -p "paste into window, then press enter to continue"
done

echo "END"
