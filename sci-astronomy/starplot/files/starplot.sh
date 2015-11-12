#!/bin/sh
set -e

test -x /usr/bin/starplot || exit 0

if [ -z "$2" ] ; then
    exit 0
fi
 

###################################
## starplot install|remove stardata
##
###################################

case $1 in
    install)
     # update any starplot data files
     SP_DIR=/var/lib/starplot
     STD_DIR=/usr/share/stardata
     SPEC_DIR=/usr/share/starplot/specfiles
          
     if [ "$2" = "gliese" ] || [ "$2" = "yale" ] ; then
	 IN=$STD_DIR/$2/catalog.dat
	 SPEC=$SPEC_DIR/$2.spec
	 OUT=$SP_DIR/$2.stars
	 CONV=/usr/bin/starconvert

         [ ! -d "$SP_DIR" ] && mkdir $SP_DIR || true
	 if [ ! -x $CONV ] ; then
	     echo "Error: Unexpectedly missing starconvert binary!" 1>&2
	     exit 1
         elif [ ! -e $IN ] || [ ! -e $SPEC ] ; then
	     echo "Warning: Unexpectedly missing $2 catalog or spec file!" 1>&2
	     exit 0
	 fi

	 # Test that output file is newer than package installation time
	 # of starplot and star catalogue packages.  If not, needs to be
	 # updated.  Have to use the files under /var/lib/dpkg/info since
	 # the mtimes for normal files in installed packages are the time of
	 # creation of the package rather than the time of installation.
	 UPDATE=true
	 if [ -f $OUT ] && [ -f /var/lib/dpkg/info/starplot.list ] \
		        && [ -f /var/lib/dpkg/info/$2.list       ] ; then
	     UPDATE=false
	     [ $OUT -nt /var/lib/dpkg/info/starplot.list ] || UPDATE=true
	     [ $OUT -nt /var/lib/dpkg/info/$2.list       ] || UPDATE=true
	 fi

	 if [ "$UPDATE" = true ] ; then
             echo "Updating $2 starplot data sets (in $SP_DIR)..."
	     $CONV $SPEC $IN $OUT > /dev/null 2>&1
	 else
	     echo "Starplot data sets for $2 are already up to date."
	 fi
	 
	 if [ -f "$OUT" ] ; then
	     linkfile=/usr/share/starplot/$2.stars
	     if [ -f "$linkfile" ] || [ -L "$linkfile" ] ; then
	        rm -f $linkfile
	     fi
	     ln -s $OUT $linkfile
	 fi    
     fi
    ;;

    remove)
    if [ "$2" = "gliese" ] || [ "$2" = "yale" ] ; then
	echo "Removing StarPlot $2 catalogue."
	find /var/lib/starplot/ -name "$2.stars" -type f -print0 | xargs -0 rm -f
	find /usr/share/starplot/ -name "$2.stars" -type l -print0 | xargs -0 rm -f
	find /usr/share/starplot/ -name "$2.stars" -type f -print0 | xargs -0 rm -f
    fi
    ;;

    *)
       exit 0
    ;;
esac

exit 0
