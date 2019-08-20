# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Extensible reader/decompiler of files in CHM format"
HOMEPAGE="http://archmage.sourceforge.net"
SRC_URI="mirror://sourceforge/archmage/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE=""

DEPEND="dev-libs/chmlib
	dev-python/pychm"
RDEPEND="${DEPEND}"

src_install() {
	distutils-r1_src_install
	dodoc INSTALL
}
