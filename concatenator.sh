#!/bin/bash

set -e

###############################################################################
# 0. Usage and assertions

usage () {
	echo "Concatenator script of sample XMLs."
	echo "@groodri, 2021"
	echo -e "\nUsage:\n$0 [XML folder] [output folder] [-h, --help]\n"
	echo "Please provide a folder with XML files as input, as well as an output folder."
	}

if [ $# != 2 ]
then
	usage
	exit 1
elif [[ $1 == "--help" || $1 == "-h" ]]
then
	usage
	exit 0
fi

xmlFolder=$1
outFolder=$2
outFile=$2/sample.xml

###############################################################################
# 1. Well, basically the whole script

# concatenate files
cat $xmlFolder/* > $outFile

# declare lines of interest
line1="<?xml version='1.0' encoding='UTF-8'?>"
line2="<SAMPLE_SET>"
line3="</SAMPLE_SET>"

# remove lines from entire file
for regex in "$line1" "$line2" "$line3"; do
    sed -i "s|$regex||g" $outFile
done

# remove blank lines
sed -i '/^$/d' $outFile

# add lines at start and end of file
sed -i "1s/^/$line1\n$line2\n/" $outFile
echo $line3 >> $outFile

exit 0