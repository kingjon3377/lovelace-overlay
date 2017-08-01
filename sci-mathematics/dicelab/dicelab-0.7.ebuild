# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="evaluate the statistical distribution of dice rolls"
HOMEPAGE="http://www.semistable.com/dicelab/"
SRC_URI="http://www.semistable.com/dicelab/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-util/treecc"
RDEPEND=""

src_prepare() {
	sed -i -e 's: -ll::' configure Makefile* || die "sed failed"
	sed -i -e 's:\$test$:$test || exit $?:' test/runtests || die "tests sed failed"
}

src_test() {
	cd test && ./runtests || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README docs/dicelab_manual.pdf
}
