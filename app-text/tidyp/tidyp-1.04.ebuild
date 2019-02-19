# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="a program to can validate HTML, and modify it to be more clean and standard"
HOMEPAGE="http://www.tidyp.com/"
SRC_URI="mirror://github/petdance/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
# Some of the tests/ folder aren't in this tarball
RESTRICT="test"

src_install() {
	emake DESTDIR="${D}" install
}
