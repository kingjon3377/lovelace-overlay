# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="tool for project management (experimental XML version)"
HOMEPAGE="http://opensched.sourceforge.net/"
SRC_URI="mirror://sourceforge/opensched/experimental/${PN}.${PV}/${PN}.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}.${PV}"

src_prepare() {
	epatch "${FILESDIR}/stringheader.patch" "${FILESDIR}/stdheader.patch"
	sed -i -e 's:Error(char \*:Error(const char *:' src/*cc src/*h || die "sed failed"
	epatch "${FILESDIR}/constchar.patch" "${FILESDIR}/samples.patch"
}

src_configure() {
	default_src_configure CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_compile() {
	default_src_compile CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
}
