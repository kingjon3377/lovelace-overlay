#!/usr/bin/python3
from gzip import GzipFile

statedict = {}

fh = open("/usr/share/misc/na.postalcodes")

for line in fh.readlines():
    if line[0] == '#':
        continue
    line = line.strip()
    splitline = line.split(":")
    if len(splitline) != 2:
        continue
    if splitline[0] not in statedict:
        statedict[splitline[0]] = splitline[1]
