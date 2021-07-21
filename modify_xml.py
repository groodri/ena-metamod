#!/usr/bin/env python

import sys
from lxml import etree as ET
from collections import OrderedDict

def make_dictionary(header, sampleData):
    dictionary = OrderedDict(zip(list(header), list(sampleData)))
    # these keys are already in our sample XML, no need to add them
    keys_to_remove = ["sample_alias", "tax_id", "scientific_name", "sample_title", "sample_description"]
    for key in keys_to_remove:
        dictionary.pop(key)

    return dictionary

def add_child(parent, tag, text):
    # create <SAMPLE_ATTRIBUTE> child element
    attrib = {}
    child = parent.makeelement("SAMPLE_ATTRIBUTE", attrib)
    parent.append(child)

    # create attribute <TAG>
    tagElement = child.makeelement("TAG", attrib)
    child.append(tagElement)
    tagElement.text = tag

    # create attribute <VALUE>
    valueElement = child.makeelement("VALUE", attrib)
    child.append(valueElement)
    valueElement.text = text

    return child

def add_elements(sampleXML, dictionary):
    with open(sampleXML, 'a+') as fh:
        # open tree at root
        parser = ET.XMLParser(remove_blank_text=True) # need for pretty XML formatting
        tree = ET.parse(sampleXML, parser)
        sample_set = tree.getroot()
        # go to parent element where children should be added
        sample = sample_set.find("SAMPLE")
        sample_attrib = sample.find("SAMPLE_ATTRIBUTES")

        # add children present in dictionary
        for key, value in dictionary.items():
            add_child(sample_attrib, key, value)
        
        # write out tree in pretty XML format
        tree.write(sampleXML, encoding='utf-8', pretty_print=True, xml_declaration=True)

    return sampleXML

def main(sampleXML, header, sampleData):
    # inputs are lists in string format, need reformatting to list
    header = header.replace("\r","").split("\t")
    sampleData = sampleData.replace("\r","").split("\t")
    
    dictionary = make_dictionary(header, sampleData)
    modifiedXML = add_elements(sampleXML, dictionary)

    return modifiedXML

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3])