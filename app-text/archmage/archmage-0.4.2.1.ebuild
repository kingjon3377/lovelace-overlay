# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Extensible reader/decompiler of files in CHM format"
HOMEPAGE="https://github.com/dottedmag/archmage"
SRC_URI="https://github.com/dottedmag/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE="dump test"

RDEPEND="dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/pychm[${PYTHON_USEDEP}]
	dump? ( app-text/htmldoc
		|| ( www-client/lynx www-client/elinks ) )"
DEPEND="${RDEPEND}
	test? ( dev-python/sgmllib3k[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest

RESTRICT="!test? ( test )"

src_prepare() {
	# version isn't in release tarball for some reason
	if ! test -f "${S}/RELEASE-VERSION"; then
		echo "${PV}" > "${S}/RELEASE-VERSION" || die
	fi
	default
}

src_install() {
	distutils-r1_src_install
	doman "${PN}.1"
}
