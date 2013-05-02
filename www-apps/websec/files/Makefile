PREFIX=/usr/local
BINDIR=$(DESTDIR)$(PREFIX)/bin
MANDIR=$(DESTDIR)$(PREFIX)/share/man
MAN1DIR=$(MANDIR)/man1
MAN5DIR=$(MANDIR)/man5
DOCDIR=$(DESTDIR)$(PREFIX)/share/doc/websec
EMACSDIR=$(DESTDIR)$(PREFIX)/share/emacs/site-lisp
VIMSYNDIR=$(DESTDIR)$(PREFIX)/share/vim/vim61/syntax

PROGSRC=websec webdiff
CONFSRC=url.list ignore.list

PROGMAN=websec.1 webdiff.1
CONFMAN=url.list.5 ignore.list.5

PROGMANHTML=websec(1).html webdiff(1).html
CONFMANHTML=url.list(5).html ignore.list(5).html

# Generated files
GENFILES=$(PROGMAN) $(CONFMAN)
HTMLFILES=$(PROGMANHTML) $(CONFMANHTML)

all: $(GENFILES)

install: all
	install -d $(BINDIR)
	install websec $(BINDIR)/
	install webdiff $(BINDIR)/

	install -d $(MAN1DIR)
	install websec.1 $(MAN1DIR)
	install webdiff.1 $(MAN1DIR)

	install -d $(MAN5DIR)
	install url.list.5 $(MAN5DIR)
	install ignore.list.5 $(MAN5DIR)

	install -d $(DOCDIR)
	install -d $(DOCDIR)/examples
	install -m 0644 url.list $(DOCDIR)/examples/
	install -m 0644 ignore.list $(DOCDIR)/examples/
	install -m 0644 README $(DOCDIR)/

	install -d $(EMACSDIR)
	install -m 0644 websec.el $(EMACSDIR)
	
	install -d $(VIMSYNDIR)
	install -m 0644 websec.vim $(VIMSYNDIR)

clean:
	rm -f $(GENFILES) pod2htm* $(HTMLFILES)

$(PROGMAN) : %.1 : %
	pod2man $< > $@

$(CONFMAN) : %.5 : %
	pod2man --section 5 $< > $@

install_html: html
	install -m 0644 $(HTMLFILES) $(DEST)

html: $(CONFMANHTML) $(PROGMANHTML)

url.list(5).html ignore.list(5).html : 
	pod2html --htmlroot . --podroot . --podpath . --infile "url.list" --outfile "url.list(5).html"
	pod2html --htmlroot . --podroot . --podpath . --infile "ignore.list" --outfile "ignore.list(5).html"

websec(1).html webdiff(1).html : 
	-rm -f pod2htm*
	pod2html --htmlroot . --podroot . --podpath . --infile "websec" --outfile "websec(1).html"
	pod2html --htmlroot . --podroot . --podpath . --infile "webdiff" --outfile "webdiff(1).html"
