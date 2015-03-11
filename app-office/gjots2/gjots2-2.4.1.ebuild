# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /home/bhepple/fun/sf/g/gjots/gjots2.ebuild,v 1.7.2.23 2012-06-02 12:42:57 bhepple Exp $

EAPI=5

inherit multilib python gnome.org

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

	insinto "/usr/$(get_libdir)/gjots2"
	doins lib/*.py

	insinto /usr/share/gjots2
	doins gjots.glade2

	pushd "${S}/pixmaps" > /dev/null
	insinto /usr/share/gjots2
	doins gjots.png gjots2-hide-all.png gjots2-merge-items.png \
		gjots2-new-child.png gjots2-new-page.png gjots2-show-all.png \
		gjots2-split-item.png

	insinto /usr/share/pixmaps
	doins gjots.png
	popd > /dev/null

	insinto /usr/share/applications
	doins gjots2.desktop

	doman doc/man/man1/{gjots2,gjots2html,gjots2docbook,docbook2gjots}.1

	dodoc README AUTHORS INSTALL ChangeLog
	insinto /usr/share/doc/${PF}
	doins doc/gjots2.gjots
	use linguas_en && doins doc/gjots2.en_US.gjots
	use linguas_fr && doins doc/gjots2.fr.gjots
	use linguas_no && doins doc/gjots2.no.gjots
	use linguas_nb && doins doc/gjots2.nb.gjots
	use linguas_ru && doins doc/gjots2.ru.gjots
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
	python_mod_optimize /usr/$(get_libdir)/gjots2
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/gjots2
}
