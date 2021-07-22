#!/bin/bash

set -e

###############################################################################
# 0. Usage and assertions

usage () {
	echo "Submitter of a sample XML to ENA."
	echo "@groodri, 2021"
	echo -e "\nUsage:\n$0 [sample XML] [submission XML] [-h, --help]\n"
	echo "Files must be in a valid XML format."
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

sample=$1
submission=$2

###############################################################################
# 1. Take in Webin credentials and submit

# Prompt Webin credentials
read -p 'Please provide your ENA Webin username: ' username
read -s -p'Please provide your ENA Webin password: ' password
echo -e "\n"

# add validation step?
# send to ENA
curl -u $username:$password -F "SUBMISSION=@${submission}" -F "SAMPLE=@${sample}" "https://www.ebi.ac.uk/ena/submit/drop-box/submit/" > xml/receipt.xml

exit 0