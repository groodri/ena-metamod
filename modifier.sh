#!/bin/bash

set -e

###############################################################################
# 0. Usage and assertions

usage () {
	echo "Modifier script of sample XMLs, adding formatted metadata."
	echo "@groodri, 2021"
	echo -e "\nUsage:\n$0 [metadata TSV file] [-h, --help]\n"
	echo "Metadata file must be in TSV format with header."
	echo "Accessions file must be in a text format, with one element per line."
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

metaFile=$1

###############################################################################
# 1. Loop over files, pick up sample alias, xref metadata, append new metadata
# to file.
# Append with python function (xmltree)? 

mkdir -p $(pwd)/xml/modified_samples
outFolder="$(pwd)/xml/modified_samples"
xmlFolder="$(pwd)/xml/samples"


for sample in $(ls $xmlFolder); do
	# line 7: <SUBMITTER_ID namespace="UNIVERSITY MEDICAL CENTER UTRECHT">E3160</SUBMITTER_ID>
	alias=$(xpath -q -e SAMPLE_SET/SAMPLE/IDENTIFIERS/SUBMITTER_ID $sample | cut -d'>' -f2 | cut -d'<' -f1)
	
	# retrieve information to add from metadata file
	header=$(head -n 1 $metaFile)
	sampleData=$(grep -n $alias $metaFile)

	# run python modifier script to write out modified xml for each sample
	python modify_xml.py $sample $header $sampleData > "$outfolder/$sample"

done
