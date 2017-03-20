# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Complete batch renamer for Linux"
HOMEPAGE="http://gprename.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-perl/glib-perl
	dev-perl/Gtk2
	dev-perl/Locale-gettext
	dev-perl/libintl-perl"
DEPEND=""

#S="${WORKDIR}/${PN}"

LANGS="ca de es et fr id it nl pl pt_BR pl_BR ru sv zh_CN"

for lang in ${LANGS}; do
	IUSE="${IUSE} linguas_${lang}"
done

src_prepare() {
	sed -i \
		-e 's/install: uninstall build/install:/' \
			Makefile || die "sed failed"
	sed -i -e '/^Version/d' bin/${PN}.desktop
	sed -i -e 's:/usr/share/icons/:$(DESTDIR)/share/icons/:' Makefile || die
	sed -i -e '/^	desktop-file-install/d' -e '/^	update-desktop-database/d' Makefile || die
	remove_lang() {
		lang="$1"
		sed -i \
			-e "/^	msgfmt -o build\/locale\/${lang}.mo	*locale\/${lang}.po$/d" \
			-e "/^	install -d \"\$(DESTDIR)\/share\/locale\/${lang}\/LC_MESSAGES\"$/d" \
			-e "/^	install -m 644 build\/locale\/${lang}.mo[ 	]*\"\$(DESTDIR)\/share\/locale\/${lang}\/LC_MESSAGES\/gprename.mo\"$/d" \
				Makefile || die "removing language ${lang} failed"
	}
	# lt.po doesn't actually exist
	remove_lang lt
	for lang in ${LANGS}; do
		if ! use linguas_${lang}; then
			einfo "Removing language ${lang}"
			remove_lang ${lang}
		else
			einfo "Keeping language ${lang}"
		fi
	done
	default
}

src_compile() {
	emake PREFIX=/usr
}

src_install() {
	dodir /usr/share/icons
	emake DESTDIR="${D}/usr" install
	domenu "bin/${PN}.desktop"
	newdoc README.TXT readme.txt
}
