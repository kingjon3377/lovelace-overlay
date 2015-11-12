# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools

DESCRIPTION="perpetual Jewish calendar"
HOMEPAGE="https://github.com/hebcal/hebcal"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

# Tests are broken, referring to a test program that doesn't exist, and even
# when that reference is patched out failing to run.
RESTRICT="test"

src_prepare() {
	# Remove reference to missing test program
#	sed -i -e 's/ hebcal-3//' tests/Makefile.am || die

	# Included generated-build-files reference versions of aclocal, etc., we don't use
	eautoreconf
}

src_test() {
	emake check
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS OLD_NEWS Manual README.md
	dohtml Manual.html
}
