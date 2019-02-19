# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="virtual dice roller"
HOMEPAGE="https://github.com/sstrickl/rolldice"
SRC_URI="https://github.com/sstrickl/rolldice/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/readline:0"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s:/usr/games$:/usr/bin:" Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}"
}

src_test() {
	cd tests
	./tests.sh || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc README Changelog CREDITS
}
