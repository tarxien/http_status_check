#!/bin/bash

#check for input file as first argument
if [ -z "$1" ]; then
	echo "HTTP status code checker by tarxien"
	echo "ERROR: no input file specified"
	echo "Usage: $0 <input_filename> <output_filename>"
	echo "e.g. $0 fqdn.txt output.txt"
	echo "Input file should contain one FQDN per line"
exit 0
fi

#check for output file as second argument
if [ -z "$2" ]; then
	echo "HTTP status code checker by tarxien"
	echo "ERROR: no output file specified"
	echo "Usage: $0 <input_filename> <output_filename>"
	echo "e.g. $0 fqdn.txt output.txt"
	echo "Input file should contain one FQDN per line"
exit 0
fi

# check for previous versions of output file, rename to .old if present
echo "HTTP status code checker by tarxien"
echo " - Loading FQDN's from $1..." 
sleep 1
echo " - Checking for old versions of output file and backing up if present. An error on the next line is normal if no previous file exists..."
sleep 1
mv "$2" "$2.old"
echo " - Following redirects..."
sleep 1
echo " - Checking status codes and writing output to file..."
sleep 1

# go through input file line by line. Follow redirects and then print the initial url, final url and status code only. output to filename specified.
while read fqdn; do
		curl -m 10 -L -s -w "FQDN:%{url}		effective URL:%{url_effective}		Status Code:%{response_code}\n" https://$fqdn -o /dev/null >> $2
done < $1

# output file to screen
echo "Done!"
sleep 1
echo " - Reading file to screen..." 
sleep 1
cat $2
