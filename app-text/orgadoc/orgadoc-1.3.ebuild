# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Organizes documents from XML descriptions"
HOMEPAGE="https://www.gnu.org/software/orgadoc"
SRC_URI="mirror://gnu/orgadoc/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/libxml2:2
	dev-libs/icu:=
	sys-libs/zlib"
DEPEND="${RDEPEND}
	app-text/texi2html"

src_prepare() {
	default
	sed -i -e 's#/@PACKAGE_NAME@-@PACKAGE_VERSION@$##' docs/Makefile.in || die
	sed -i -e '/DATADIR/d' Makefile.in || die # installs same files as go in /usr/share/doc/$PF
}

src_install() {
	dodir /usr/share/man/man1
	default
}
