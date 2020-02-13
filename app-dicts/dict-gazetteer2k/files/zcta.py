#!/usr/bin/python3
import dictdlib, dictclient, re

rfile = open("zcta5.txt", "rt")
zctanumdict = {}

for line in rfile:
    line = line.strip()
    new = {}
    new['stateabbr'] = line[0:2]
    new['name'] = line[2:66].strip()
    match = re.search('^(\d\d\d\d\d )', new['name'])
    if not match:
        continue
    new['zipcode'] = int(match.group(1))
    new['population'] = int(line[66:75])
    new['housingunits'] = int(line[75:84])
    new['landarea_m'] = float(line[84:98])
    new['waterarea_m'] = float(line[98:112])
    new['landarea_mi'] = float(line[112:124])
    new['waterarea_mi'] = float(line[124:136])
    new['lat'] = float(line[136:146])
    new['long'] = float(line[146:157])
    zctanumdict[new['zipcode']] = new
