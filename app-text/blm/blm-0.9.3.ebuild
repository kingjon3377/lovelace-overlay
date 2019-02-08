# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Boolean line manipulator utility program for set operations"
HOMEPAGE="https://complearn.org/download.html"
SRC_URI="https://complearn.org/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dodoc AUTHORS ChangeLog NEWS README
	emake DESTDIR="${D}" install install-man
}
