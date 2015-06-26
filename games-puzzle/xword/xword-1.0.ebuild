# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit games eutils python-single-r1

DESCRIPTION="GTK program for doing crossword puzzles"
HOMEPAGE="http://x-word.org/"
SRC_URI="http://x-word.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-python/pygtk:2[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/xword_1.0-7.diff"
	mv -i debian/xword.1 debian/xword.6 || die "fixing man page section failed"
}

python_test() {
	$(PYTHON) test.py || die "tests failed"
}

src_install() {
	dodir /usr/share/games/xword
	insinto /usr/share/games/xword
	doins *png
	dogamesbin xword
	doman debian/xword.6
}
