# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="The dependency analyst"
HOMEPAGE="http://archive.debian.net/sarge/dep.pl"
SRC_URI="http://archive.debian.org/debian/pool/main/d/${PN/_/.}/${PN/_/.}_${PV}-5.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${DEPEND}
	app-text/texi2html"

S="${WORKDIR}/${P/_/.}"

src_compile() {
	emake all
	# FIXME: Figure out where it goes, and use fperms in src_install, if
	# possible
	chmod 755 src/dep.pl-config
}

src_install() {
	dodir /usr/share/doc/${PF}
	emake DESTDIR="${D}" docdir="/usr/share/doc/${PF}" install
	dodoc debian/dep.pl-manual debian/copyright debian/changelog \
		debian/changelog.old NEWS README THANKS TODO
}
