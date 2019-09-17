#!/usr/bin/env python3
import sys


data=open(sys.argv[1]).read().split("\n")
for n,items in enumerate(data):
    if items.startswith("    <name>io.compression.codec"):
        data[n-2]= "<!--"
        data[n+2]= data[n+2]+" -->\n"
print ("\n".join(data))