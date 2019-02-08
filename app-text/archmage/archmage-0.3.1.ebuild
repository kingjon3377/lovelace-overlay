# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Extensible reader/decompiler of files in CHM format"
HOMEPAGE="http://archmage.sourceforge.net"
SRC_URI="https://github.com/dottedmag/archmage/archive/0.3.1.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="dump"

DEPEND="dev-python/beautifulsoup:python-2[${PYTHON_USEDEP}]
	dev-python/pychm[${PYTHON_USEDEP}]
	dump? ( app-text/htmldoc
		|| ( www-client/lynx www-client/elinks ) )"
RDEPEND="${DEPEND}"

src_prepare() {
	# version isn't in release tarball for some reason
	echo "${PV}" > "${S}/RELEASE-VERSION" || die
	default
}

src_install() {
	distutils-r1_src_install
	doman "${PN}.1"
}
