# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="evaluate the statistical distribution of dice rolls"
HOMEPAGE="http://www.semistable.com/dicelab/"
SRC_URI="http://www.semistable.com/dicelab/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-util/treecc"
RDEPEND=""

DOCS=( AUTHORS ChangeLog NEWS README docs/dicelab_manual.pdf )

src_prepare() {
	sed -i -e 's: -ll::' configure Makefile* || die "sed failed"
	sed -i -e 's:\$test$:$test || exit $?:' test/runtests || die "tests sed failed"
}

src_test() {
	cd test && ./runtests || die "tests failed"
}
