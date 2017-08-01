# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="Tool for parsing flat and CSV files and converting them to different formats"
HOMEPAGE="http://ff-extractor.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}/${PV}/ffe-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/ffe-${PV}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
	mv -i "${D}/usr/share/doc/ffe"/* "${D}/usr/share/doc/${P}" || die "fixing docs failed"
}
