#!/usr/bin/env python3
import sys


data=open(sys.argv[1]).read().split("\n")
for n,items in enumerate(data):
    if items.startswith("</configuration>"):
        data[n-1]= data[n-1]+"<property>\n  <name>dfs.client.use.datanode.hostname</name>\n  <value>true</value>\n </property>"
print ("\n".join(data))