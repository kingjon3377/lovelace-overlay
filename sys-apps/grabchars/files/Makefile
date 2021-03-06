#	$Header: Makefile.dist,v 1.9 89/12/29 21:14:31 daniel grabchars_1_9 $
#
#       Makefile for grabchars
#
#	Dan Smith (daniel@island.uu.net), November 1988, April 1990
#
#	defines...
#
#	BSD or SYS_V, if you port to something else, add a comment
#	here, #ifdef the source and please send me the patches, thanks!
#
#	DV_ERASE is a stab at putting erase/kill processing
#	in this, it will only work under BSD at the moment 
#
#	Use -DSIGRET=void for Sun OS 4.X...
#
#	Uncomment the one that applies...
#DEFS = -DBSD -DDV_ERASE -DSIGRET=void
DEFS = -DSYS_V

SRCS =	globals.c grabchars.c sys.c
OBJS =	globals.o grabchars.o sys.o
HDRS =	grabchars.h
MAN_PAGE = grabchars.1
OTHERS = README Config TODO Makefile.dist demo
ALL_TEXT = $(OTHERS) $(MAN_PAGE) $(SRCS) $(HDRS)

#	where to put things...
BIN_DIR = $(DESTDIR)/usr/bin
MAN_DIR = $(DESTDIR)/usr/share/man/man1

#	for rcs...
STATE = grabchars_1_9
VERSION = 1.9

#	change to suit...
PRINTER = -Pceylonlw
EDITOR = /bin/true

#	if you have this, check the path.  If you don't, leave it alone...
MKID = mkid
SHAR = shar -v

#CC = cc
CFLAGS = $(USER_CFLAGS)

#	force this, leave csh out of it...
SHELL=/bin/sh

.c.o:
	$(CC) -c $(CFLAGS) $(DEFS) $*.c

all: grabchars

release:
	@$(MAKE) CFLAGS=$(CFLAGS) all

grabchars: $(OBJS)
	@echo loading...
	$(CC) $(CFLAGS) $(OBJS)  -o grabchars
	@echo done...

install: release
	- cp grabchars $(BIN_DIR)
	- cp grabchars.1 $(MAN_DIR)
 
id: $(SRCS) $(HDRS)
	- $(MKID) $(SRCS) $(HDRS) || echo $(MKID) not available...

e: $(SRCS) $(HDRS)
	$(EDITOR) $(SRCS) $(HDRS) Makefile

pgrind:
	@echo pgrinding out sources...
	lpq $(PRINTER)
	pgrind $(SRCS) $(HDRS) Makefile

rcs:
	@echo checking grabchars in to RCS...
	ci -s$(STATE) -r$(VERSION) -f -u $(ALL_TEXT)

shar:
	@echo bundling up grabchars for transit...
	$(SHAR) $(ALL_TEXT) > grabchars.shar

clean: id tags
	- touch $(OBJS) grabchars
	- /bin/rm $(OBJS) grabchars

depend: 
	@echo making dependencies...
	sed -n '1,/^#	lines after this point/p' Makefile >.depends &&\
	$(CC) -MM $(SRCS) | grep -v "/usr/include" | \
	tee /dev/tty >> .depends && mv .depends Makefile

tags: $(SRCS)
	ctags $(SRCS)

#       lines after this point produced with cc -M, leave this line here
