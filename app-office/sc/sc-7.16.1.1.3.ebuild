# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Spreadsheet Calculator"
HOMEPAGE="https://github.com/n-t-roff/sc"
SRC_URI="https://github.com/n-t-roff/${PN}/archive/refs/tags/$(ver_rs 2 _).tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="Unlicense"
KEYWORDS="amd64 ppc sparc x86"

COMMON_DEPEND="
	>=sys-libs/ncurses-5.2:=
"
DEPEND="
	virtual/pkgconfig
"
RDEPEND="
	${COMMON_DEPEND}
"

S="${WORKDIR}/${PN}-$(ver_rs 2 _)"

PATCHES=(
	"${FILESDIR}/${PN}-7.16.1.1.2-no-rpath.patch"
)

src_prepare() {
	default
	if has_version 'sys-libs/ncurses[tinfo]'; then
		sed -i -e 's@"-lncursesw"@"-lncursesw -ltinfo"@' configure || die
	fi
	sed -i -e 's@ -s$@@' Makefile.* || die
}

src_configure() {
	# This isn't from autoconf
	tc-export CC
	./configure || die
}

src_compile() {
	tc-export PKG_CONFIG
	# no autoconf
	emake prefix=/usr

	emake prefix=/usr ${PN}.1
}

DOCS=( CHANGES CHANGES-git README README.md SC.MACROS TODO psc.doc sc-7.16.lsm sc.doc scqref.doc tutorial.sc xsc.doc )

src_install() {
	emake prefix="${D}/usr" install
	einstalldocs
}
