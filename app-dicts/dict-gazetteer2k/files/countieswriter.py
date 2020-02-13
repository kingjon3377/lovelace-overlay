#!/usr/bin/python3
print("Loading states.")
from states import statedict
print("Processing.")
from dictdlib import DictWriter
import re

def withstate(city, state):
    return [city, city + ", " + state]

rfile = open("county2k.txt", "rt", encoding="latin1")
writer = DictWriter('gazetteer2k-counties',
                    'http://www.census.gov/geo/www/gazetteer/places2k.html',
                    'U.S. Gazetteer Counties (2000)',
                    """The original data is available from:

http://www.census.gov/ftp/pub/tiger/tmz/gazetteer/county2k.txt
http://www.census.gov/ftp/pub/tiger/tms/gazetteer/zips.txt

  The original U.S. Gazetteer Place and Zipcode Files
  are provided by the U.S. Census Bureau and are in
  the Public Domain."""
                    )

for line in rfile:
    line = line.strip()
    stateabbr = line[0:2]
    statefips = line[2:4]
    name = line[7:71].strip()
    population = int(line[71:80])
    housingunits = int(line[80:89])
    landarea_m = float(line[89:103])
    waterarea_m = float(line[103:117])
    landarea_mi = float(line[117:129])
    waterarea_mi = float(line[129:141])
    lat = float(line[141:151])
    longit = float(line[151:162])

    indexwords = []
    
    match = re.search('^(.+) (County|Municipio|city|Parish|Census Area|Borough|Municipality)$', name)
    if match:
        countyname = match.group(1)
        type = match.group(2)
        indexwords.extend(withstate(countyname, stateabbr))
    else:
        countyname = name
        type = 'County'

    indexwords.extend(withstate(name, stateabbr))

    defstr = "%s -- U.S. %s in %s\n" % \
             (countyname, type, statedict[stateabbr])
    defstr += "   Population (2000):    %d\n" % population
    defstr += "   Housing Units (2000): %d\n" % housingunits
    defstr += "   Land area (2000):     %f sq. miles (%f sq. km)\n" % \
              (landarea_mi, landarea_m / 1000000)
    defstr += "   Water area (2000):    %f sq. miles (%f sq. km)\n" % \
              (waterarea_mi, waterarea_m / 1000000)
    defstr += "   Total area (2000):    %f sq. miles (%f sq. km)\n" % \
              (landarea_mi + waterarea_mi,
               landarea_m / 1000000 + waterarea_m / 1000000)
    defstr += "   Located within:       %s (%s), FIPS %s\n" % \
              (statedict[stateabbr], stateabbr, statefips)
    defstr += "   Location:             %f %s, %f %s\n" % ( \
        abs(lat), lat > 0 and 'N' or 'S',
        abs(longit), longit > 0 and 'E' or 'W')
    defstr += "   Headwords:\n"
    for hw in indexwords:
        defstr += "    %s\n" % hw
    writer.writeentry(defstr, indexwords)
writer.finish()
