# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Personal time management system"
HOMEPAGE="http://www.paladin.demon.co.uk/tag-types/taglog/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

BDEPEND="dev-lang/tcl"
DEPEND="dev-lang/tk:="
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s:/usr/share/doc/${PN}\":/usr/share/doc/${PF}/html\":g" install.tcl \
		|| die
	default
}

src_install() {
	dodir /usr/share/man/man1
	dodir /usr/share/man/man3
	dodir /usr/share/doc/${PF}/html
	tclsh install.tcl -debian "${D}" || die "install failed"
	dodoc changelog README
}
