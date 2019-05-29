# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="the war game of the century"
HOMEPAGE="http://www.catb.org/~esr/vms-empire/"
SRC_URI="http://www.catb.org/~esr/vms-empire/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e '/^install/s/uninstall//' Makefile || die
	default
}

# TODO: Convert to DOCS=() default_src_install
src_install() {
	emake DESTDIR="${D}" install
	dodoc BUGS NEWS README HACKING
}
