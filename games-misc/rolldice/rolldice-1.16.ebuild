# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="virtual dice roller"
HOMEPAGE="https://github.com/sstrickl/rolldice"
SRC_URI="https://github.com/sstrickl/rolldice/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

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

# TODO: Use DOCS=() default_src_install
src_install() {
	emake DESTDIR="${D}" install
	dodoc README Changelog CREDITS
}
