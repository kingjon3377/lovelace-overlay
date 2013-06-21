# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /cvsroot/gjots2/gjots/gjots2.ebuild,v 1.7.2.15 2007/07/28 12:11:45 bhepple Exp $

EAPI=5

inherit python gnome.org

DESCRIPTION="A graphical (GNOME 2) jotter tool"
HOMEPAGE="http://bhepple.freeshell.org/gjots/"
SRC_URI="http://bhepple.freeshell.org/gjots/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="linguas_en linguas_fr linguas_no linguas_nb linguas_ru linguas_it linguas_cs"

DEPEND="dev-lang/python:2.7
	gnome-base/libglade:2.0
	gnome-base/libgnome
	dev-python/gnome-python-base:2
	dev-python/libgnome-python:2
	dev-python/pygtk:2
	dev-python/pyorbit"
RDEPEND="${DEPEND}"

#MAKEOPTS="${MAKEOPTS} -j1"

#src_compile() {
#	emake
#}

src_install() {
	dobin bin/gjots2 bin/gjots2html bin/gjots2html.py bin/gjots2docbook \
		bin/docbook2gjots bin/gjots2emacs bin/gjots2lpr

	insinto /usr/lib/gjots2
	doins lib/*.py

	insinto /usr/share/gjots2
	doins gjots.glade3

	insinto /usr/share/gjots2
	doins gjots.png gjots2-hide-all.png gjots2-merge-items.png \
		gjots2-new-child.png gjots2-new-page.png gjots2-show-all.png \
		gjots2-split-item.png

	insinto /usr/share/pixmaps
	doins gjots.png

	insinto /usr/share/applications
	doins gjots2.desktop

	insinto /usr/share/man/man1
	doins share/man/man1/gjots2.1 share/man/man1/gjots2html.1 \
		share/man/man1/gjots2docbook.1 share/man/man1/docbook2gjots.1

	dodoc README AUTHORS INSTALL ChangeLog
	insinto /usr/share/doc/${PF}
	doins gjots2.gjots
	use linguas_en && doins gjots2.en_US.gjots
	use linguas_fr && doins gjots2.fr.gjots
	use linguas_no && doins gjots2.no.gjots
	use linguas_nb && doins gjots2.nb.gjots
	use linguas_ru && doins gjots2.ru.gjots
# not available:
#	use linguas_it && doins gjots2.it.gjots
#	use linguas_cs && doins gjots2.cs.gjots

	insinto /usr/share/locale/en_US/LC_MESSAGES
	use linguas_en && doins po/en_US/LC_MESSAGES/gjots2.mo

	for lang in fr no nb ru it cs; do
		use linguas_${lang} && \
			insinto /usr/share/locale/${lang}/LC_MESSAGES && \
			doins po/${lang}/LC_MESSAGES/gjots2.mo
	done
}

pkg_postinst() {
	python_mod_optimize /usr/lib/gjots2
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/gjots2
}
