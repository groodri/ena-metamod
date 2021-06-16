#!/bin/bash

set -e

###############################################################################
# 0. Usage and assertions

usage () {
	echo "Retrieval script for sample XMLs of a list of ENA accession numbers in a tsv file."
	echo "@groodri, 2021"
	echo -e "\nUsage:\n$0 [input file] [optional: filter file] [-h, --help]\n"
	echo "Input file must be in TSV format with header."
	}

if [ $# == 0 ]
then
	usage
	exit 1
elif [[ $1 == "--help" || $1 == "-h" ]]
then
	usage
	exit 0
fi

inputFile=$1
filterFile=$2

###############################################################################
# 1. Input TSV handling
# Retrieve sample accessions from input file, save them into array

filteredFile=filtered_input.txt

ids=($(awk -F '\t' -vcol=ID '(NR==1){colnum=-1;for(i=1;i<=NF;i++)if($(i)==col)colnum=i;}{print $(colnum)}' $filterFile | awk 'NR!=1' -))

declare -a accessions
for id in ${ids[@]}; do
	accessions[${#accessions[@]}]=$(grep $id $inputFile | cut -f 3)
done

echo ${accessions[@]}

###############################################################################
# 2. Download sample XML files
# Loop over accession list and retrieve individual sample XML files

#rm -rf "$(pwd)/xml/samples"; mkdir -p "$(pwd)"/xml/samples

#for acc in ${accessions[@]}; do
#	wget -nv "https://www.ebi.ac.uk/ena/browser/api/xml/$acc" -O "xml/samples/$acc.xml"
#done

#exit 0
