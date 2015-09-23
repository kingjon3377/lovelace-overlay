print "Loading states."
from states import statedict
print "Loading zips."
from zips import zipcodesnumdict, zipcodesdict
print "Loading ZCTA."
from zcta import zctanumdict
print "Processing."
from dictdlib import DictWriter
import re

def withstate(city, state):
    return [city, city + ", " + state]

def uniq(list):
    if len(list) < 2:
        return list
    retval = [ list[0] ]
    for item in list[1:]:
        if retval[-1] != item:
            retval.append(item)
    return retval

writer = DictWriter('gazetteer2k-zips',
                    'http://www.census.gov/geo/www/gazetteer/places2k.html',
                    'U.S. Gazetteer Zip Code Tabulation Areas (2000)',
                    """The original data is available from:

http://www.census.gov/ftp/pub/tiger/tmz/gazetteer/zcta5.txt
http://www.census.gov/ftp/pub/tiger/tms/gazetteer/zips.txt

  The original U.S. Gazetteer Place and Zipcode Files
  are provided by the U.S. Census Bureau and are in
  the Public Domain."""
                    )

biglist = zipcodesnumdict.keys() + zctanumdict.keys()
biglist.sort()
biglist = uniq(biglist)

for zipcode in biglist:
    indexwords = ["%05d" % zipcode]
    defstr = "%05d -- U.S. ZIP code\n" % zipcode


    if zipcodesnumdict.has_key(zipcode):
        name = zipcodesnumdict[zipcode]
        city, stateabbr = name.split(",")
        stateabbr = stateabbr.strip()
        state = statedict[stateabbr]
        defstr += "   Municipality (1990):  %s\n" % (city + ", " + state)
        defstr += "   All ZIPs for this municipality (1990):"
        zipcount = 0
        for allzipcode in zipcodesdict[name]:
            if zipcount % 6 == 0:
                defstr += "\n                        "
            zipcount += 1
            defstr += " " + allzipcode
        defstr += "\n"

    if zctanumdict.has_key(zipcode):
        e = zctanumdict[zipcode]
        defstr += "   Population (2000):    %d\n" % e['population']
        defstr += "   Housing Units (2000): %d\n" % e['housingunits']
        defstr += "   Land area (2000):     %f sq. miles (%f sq. km)\n" % \
                  (e['landarea_mi'], e['landarea_m'] / 1000000)
        defstr += "   Water area (2000):    %f sq. miles (%f sq. km)\n" % \
                  (e['waterarea_mi'], e['waterarea_m'] / 1000000)
        defstr += "   Total area (2000):    %f sq. miles (%f sq. km)\n" % \
                  (e['landarea_mi'] + e['waterarea_mi'],
                   e['landarea_m'] / 1000000 + e['waterarea_m'] / 1000000)
        defstr += "   Located within:       %s (%s)\n" % \
                  (statedict[e['stateabbr']], e['stateabbr'])
        defstr += "   Location:             %f %s, %f %s\n" % ( \
            abs(e['lat']), e['lat'] > 0 and 'N' or 'S',
            abs(e['long']), e['long'] > 0 and 'E' or 'W')
        
    writer.writeentry(defstr, indexwords)
writer.finish()
