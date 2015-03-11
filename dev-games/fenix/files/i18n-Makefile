# Copyright 2007 Miriam Ruiz <little_miry@yahoo.es>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Library General Public
# License as published by the Free Software Foundation; either
# version 2 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Library General Public License for more details.
#
# You should have received a copy of the GNU Library General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.

INSTALLPREFIX=./

all: fenix-fxc.pot fenix-fxi.pot build

fenix-fxc.pot:
	cd ../.. && \
		xgettext \
			-k_ \
			-o debian/i18n/$@ \
			--from-code=iso-8859-1 \
			`grep -r libintl.h fxc fpg map | awk -F: '{print $$1}' | grep -E .*[cChH]$$ | sort --unique`

fenix-fxi.pot:
	cd ../.. && \
		xgettext \
			-k_ \
			-o debian/i18n/$@ \
			--from-code=iso-8859-1 \
			`grep -r libintl.h fxi | awk -F: '{print $$1}' | grep -E .*[cChH]$$ | sort --unique`

build: build-stamp
build-stamp:
	for f in *.po; do \
		i=`basename $$f .po` ; \
		echo Building Language File \"$$i.mo\" ; \
		msgfmt -v $$f -o $$i.mo || exit 1 ;\
	done
	touch build-stamp

clean:
	#for f in *.po; do i=`echo $$f | awk 'BEGIN {FS="."} {print $$1}'`; rm -rf "$$i"; done
	rm -f *.mo
	rm -f *.pot
	rm -f build-stamp

install: build-stamp
	for f in *.mo; do i=`basename $$f .mo` ; \
		lang=`echo $$i | awk -F_ '{print $$2}'` ; \
		file=`echo $$i | awk -F_ '{print $$1}'` ; \
		echo Installing Language \"$$lang\" for \"$$file\" ; \
		install -d $(INSTALLPREFIX)$$lang ; \
		install -p -d -m 755 $(INSTALLPREFIX)$$lang/LC_MESSAGES ; \
		install -m 644 $$f $(INSTALLPREFIX)$$lang/LC_MESSAGES/$$file.mo; \
	done
