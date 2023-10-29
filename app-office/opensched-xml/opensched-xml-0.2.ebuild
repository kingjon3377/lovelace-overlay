# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="tool for project management (experimental XML version)"
HOMEPAGE="https://opensched.sourceforge.net/"
SRC_URI="mirror://sourceforge/opensched/experimental/${PN}.${PV}/${PN}.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="${DEPEND}
	dev-texlive/texlive-latexextra
	app-text/psutils"

S="${WORKDIR}/${PN}.${PV}"

PATCHES=(
	"${FILESDIR}/stringheader.patch"
	"${FILESDIR}/stdheader.patch"
	"${FILESDIR}/constchar.patch"
	"${FILESDIR}/samples.patch"
)

src_prepare() {
	sed -i -e 's:Error(char \*:Error(const char *:' src/*cc src/*h || die "sed failed"
	default
}

src_configure() {
	default_src_configure CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_compile() {
	default_src_compile CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}
