# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="tool for project management"
HOMEPAGE="https://opensched.sourceforge.net/"
SRC_URI="https://downloads.sourceforge.net/${PN}/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-texlive/texlive-latexextra
	app-text/psutils"
RDEPEND="${DEPEND}"

PATCHES=(
	# TODO: split up the Debian patch
	# TODO: see if Debian has added any more patches since
	"${FILESDIR}/opensched_0.4.4-6.diff"
	debian/patches/01-sched.cc.dpatch
	debian/patches/02-opensched.1.in.dpatch
	debian/patches/03-gcc43_fix.dpatch
	debian/patches/04-manpage-typos.dpatch
	"${FILESDIR}/samples.patch"
)

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" CXX=$(tc-getCXX) CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"
}

# TODO: Delegate to default_src_install
src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog ChangeLog.0 NEWS README TODO USAGE
	docinto gui
	dodoc gui/README gui/*html
	dodoc -r examples/sample examples/toffee
}
