print "Loading states."
from states import statedict
print "Loading zips."
from zips import zipcodesdict
print "Processing."
from dictdlib import DictWriter

import re
rfile = open("places2k.txt", "rt")
writer = DictWriter('gazetteer2k-places',
                    'http://www.census.gov/geo/www/gazetteer/places2k.html',
                    'U.S. Gazetteer Places (2000)',
                    """The original data is available from:

http://www.census.gov/ftp/pub/tiger/tmz/gazetteer/places2k.txt
http://www.census.gov/ftp/pub/tiger/tms/gazetteer/zips.txt

  The original U.S. Gazetteer Place and Zipcode Files
  are provided by the U.S. Census Bureau and are in
  the Public Domain."""
                    )

for line in rfile.xreadlines():
    line = line.strip()
    stateabbr = line[0:2]
    statefips = line[2:4]
    placefips = line[4:9]
    name = line[9:73].strip()
    population = int(line[73:82])
    housingunits = int(line[82:91])
    landarea_m = float(line[91:105])
    waterarea_m = float(line[105:119])
    landarea_mi = float(line[119:131])
    waterarea_mi = float(line[131:143])
    lat = float(line[143:153])
    long = float(line[153:164])

    indexwords = []

    # Convert name to type.  Some icky special cases.

    # Convert "Indianapolis city (balance)" to "Indianapolis city"
    
    name = re.sub('\s*\(.+\)\s*', ' ', name)
    name = name.strip()

    for splitspecial in ['-', ',']:
        if len(name.split(splitspecial)) == 2:
            # Index "Nashville-Davidson (balance)" under "Nashville"
            # and "Nashville, TN" as well as the full thing.
            # Same for "Lynchburg, Moore County"
            left, right = name.split(splitspecial)
            indexwords.append(left)
            indexwords.append(left + ", " + stateabbr)

    match = re.search('^(.+) (city|town|village|CDP|urbana|comunidad|borough|municipality)$', name)
    if not match:
        cityname = name
        type = 'unknown location type'
    else:
        cityname = match.group(1)
        type = match.group(2)

    if type == 'CDP':
        type = 'Census Designated Place'

    indexwords.append(cityname)
    indexwords.append(cityname + ", " + stateabbr)

    defstr = "%s, %s -- U.S. %s in %s\n" % \
             (cityname, stateabbr, type, statedict[stateabbr])
    defstr += "   Population (2000):    %d\n" % population
    defstr += "   Housing Units (2000): %d\n" % housingunits
    defstr += "   Land area (2000):     %f sq. miles (%f sq. km)\n" % \
              (landarea_mi, landarea_m / 1000000)
    defstr += "   Water area (2000):    %f sq. miles (%f sq. km)\n" % \
              (waterarea_mi, waterarea_m / 1000000)
    defstr += "   Total area (2000):    %f sq. miles (%f sq. km)\n" % \
              (landarea_mi + waterarea_mi,
               landarea_m / 1000000 + waterarea_m / 1000000)
    defstr += "   FIPS code:            %s\n" % placefips
    defstr += "   Located within:       %s (%s), FIPS %s\n" % \
              (statedict[stateabbr], stateabbr, statefips)
    defstr += "   Location:             %f %s, %f %s\n" % ( \
        abs(lat), lat > 0 and 'N' or 'S',
        abs(long), long > 0 and 'E' or 'W')

    zipcodes = []
    zcsearchlist = indexwords
    zcsearchlist.reverse()
    for zctry in zcsearchlist:
        zctry = zctry.upper()
        if zipcodesdict.has_key(zctry):
            zipcodes = zipcodesdict[zctry]
            break

    defstr += "   ZIP Codes (1990):    "
    zipcount = 0
    for zipcode in zipcodes:
        if zipcount and zipcount % 6 == 0:
            defstr += "\n                        "
        zipcount += 1
        defstr += " " + zipcode
    defstr += "\n   Note: some ZIP codes may be omitted esp. for suburbs.\n"
    defstr += "   Headwords:\n"
    for hw in indexwords:
        defstr += "    %s\n" % hw
    writer.writeentry(defstr, indexwords)
writer.finish()
