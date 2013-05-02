# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt4-r2 eutils

DESCRIPTION="featured lightweight graphical organizer"
HOMEPAGE="http://qorganizer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PN/o/O}%20v${PV}/${PN/o/O}-v${PV}-5.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

CDEPEND="dev-qt/qtsql:4
	dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	media-gfx/imagemagick"

S="${WORKDIR}/${P}/src"

src_prepare() {
	cd "${WORKDIR}" && mv -i ${PN/o/O}-v${PV}-5 ${P} || die "fixing dir name failed"
	epatch "${FILESDIR}/qorganizer_3.1.4-2.diff"
	cd "${S}" && mv -i ../debian .
	# We originally used find -exec dos2unix, but wanted to drop the dependency
	# ... but edos2unix is a shell function. Fortunately none of the paths in
	# the package contain spaces.
	for file in $(find . -type f -print);do
		edos2unix ${file}
		edos2unix ${file}
	done
	epatch debian/patches/*patch
	default_src_prepare
}

src_compile() {
	default_src_compile
	convert images/icon.png menuicon.xpm
}

src_install() {
	dobin ${PN}
	insinto /usr/share/${PN}
	doins menuicon.xpm
	insinto /usr/share/${PN}/images
	doins images/*
	insinto /usr/share/${PN}/translations
	doins lang/*
	doman debian/${PN}.1
	dodoc debian/{changelog,copyright,README.Debian}
}
