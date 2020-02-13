#!/usr/bin/python3
import sys, dictdlib

# Conversion script by John Goerzen

itextfile = open("introduction.txt", "rt")


dw = dictdlib.DictWriter("moby-thesaurus",
                         'http://www.ibiblio.org/pub/docs/books/gutenberg/etext02/mthes10.zip',
                         'Moby Thesaurus II by Grady Ward, 1.0',
                         itextfile.read(-1))

while 1:
    line = sys.stdin.readline()
    if not line:
        break
    line.strip()
    base, d = line.split(',', 1)
    defstr = ""
    defline = "   "
    count = 0
    for defword in d.split(','):
        count += 1
        if len(defline) + len(defword) + 3 > 70:
            defstr += defline + "," + "\n"
            defline = "   " + defword
        elif defline == "   ":
            defline += defword
        else:
            defline += ", " + defword
    if defline != "   ":
        defstr += defline + "\n"
    dw.writeentry("%s Moby Thesaurus words for \"%s\":\n" % (count, base) + \
                  defstr, [base])
dw.finish()
