#!/bin/bash

if ! crontab -l | grep -i "sdel.sh"; 
then 
crontab -l > mycrone
file="$(pwd)/sdel.sh"
echo "0 6 * * * $file" >> mycrone
crontab mycrone
rm mycrone 
fi
find ~/TRASH/* -mmin +2880 -exec rm {} \;
mkdir -p ~/TRASH
for files in $@
do
if [ -f "$files.tar.gz" ]
	then
	echo "File already compressed" 
else 
	tar czf $files.tar.gz $files
	mv $files.tar.gz ~/TRASH
	rm -r $files
fi
done
