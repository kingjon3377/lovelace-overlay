# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Tool that performs fuzzy hash analysis of similar (but not identical) files"
HOMEPAGE="http://ssdeep.sourceforge.net/"
SRC_URI="mirror://sourceforge/ssdeep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	emake install DESTDIR="${D}"
	dodoc AUTHORS README NEWS ChangeLog FILEFORMAT
}
