#!/usr/bin/env python

import argparse
from xml.etree as etree
from xml.dom import minidom

parser = argparse.ArgumentParser()
parser.add_argument()

def make_dictionary(header, sampleData):
    dictionary = dict(zip(list(header), list(sampleData)))
    return dictionary

def add_elements(sampleXML, dictionary):
    doc = minidom.parse(sampleXML)
    with open(modified_xml, 'w') as outFile:
        sample_set = etree.Element("SAMPLE_SET")
        sample = etree.SubElement(sample_set, "SAMPLE")
        identifiers = etree.SubElement(sample, "IDENTIFIERS")


    return modified_xml

def write_out(modified_xml):
    return

def main(sampleXML, header, sampleData):
    dictionary = make_dictionary(header, sampleData)
    modified_xml = add_elements(sampleXML, dictionary)
    write_out(modified_xml)

if __name__ == "__main__":
    main(sample, header, sampleData)