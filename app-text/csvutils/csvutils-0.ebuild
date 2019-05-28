# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Utilities for working with CSV files"
HOMEPAGE="http://lorance.freeshell.org/csvutils/"
SRC_URI="http://lorance.freeshell.org/${PN}/${PN}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	virtual/awk"

S="${WORKDIR}/${PN}"

# csv2sql part of the test fails under the ebuild environment and not when run by hand!
RESTRICT="test"

src_test() {
	./test.sh || die
	diff test.out result.txt > /dev/null || die "Test failed"
}

src_install() {
	dobin csv2csv csv2html csv2sc csv2sql
	dodoc README CHANGES
}
