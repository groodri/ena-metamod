# metadata-sub
Modify sample metadata XML files from ENA, then resubmit them.

Developed for the VRE crosswords project ('GSC MIxS human associated' metadata schema).

### Prerequisites
- Python3
- Python3 library lxml
- curl

### Workflow
1. retriever.sh
2. modifier.sh
3. concatenator.sh
4. submitter.sh

### Usage
##### 1. retreiver.sh
`./retriever.sh input_file.tsv filter_file.tsv`

##### 2. modifier.sh
(Assumes sample XML files are in folder 'xml/samples'
`./modifier.sh metadata_file.tsv`

##### 1. concatenator.sh
`./concatenator.sh xml/modified_samples xml`

##### 1. submitter.sh
First validate your XML file for submission:

`./submitter.sh xml/sample.xml xml/validate.xml`

If submission is successful (i.e. if 'success="true"' in line 3 of 'xml/receipt.xml'), then you can do the real submission:

`./submitter.sh xml/sample.xml xml/submission.xml`
