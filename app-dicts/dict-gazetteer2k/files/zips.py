import dictdlib, dictclient
from states import statedict

rfile = open("zips.txt", "rt")

zipcodesdict = {}
zipcodesnumdict = {}

for line in rfile.xreadlines():
    line = line.strip()
    fips, zipcode, state, city, junk = line.split(",", 4)
    zipcode = dictclient.dequote(zipcode)
    state = dictclient.dequote(state)
    city = dictclient.dequote(city)
    indexval = "%s, %s" % (city, state)
    if not zipcodesdict.has_key(indexval):
        zipcodesdict[indexval] = []
    zipcodesdict[indexval].append(zipcode)
    zipcodesnumdict[int(zipcode)] = "%s, %s" % (city, state)
