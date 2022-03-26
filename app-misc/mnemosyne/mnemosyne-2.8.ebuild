# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_SINGLE_IMPL=true
# Python 3.10 blocked by app-misc/anki
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1 edos2unix

DESCRIPTION="Sophisticated flash-card tool also used for long-term memory research"
HOMEPAGE="https://www.mnemosyne-proj.org/"
SRC_URI="mirror://sourceforge/${PN}-proj/${PN}/${P/2a/2}/${P/m/M}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="latex test"

MY_DEPEND="latex? ( app-text/dvipng )
	$(python_gen_cond_dep '
		dev-python/PyQt5[${PYTHON_USEDEP}]
		dev-python/matplotlib[${PYTHON_USEDEP}]
		dev-python/cherrypy[${PYTHON_USEDEP}]
		dev-python/webob[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/cheroot[${PYTHON_USEDEP}]
	')"

DEPEND="${DEPEND}
	${MY_DEPEND}
	$(python_gen_cond_dep '
		dev-python/sphinx[${PYTHON_USEDEP}]')
	test? ( $(python_gen_cond_dep '
			dev-python/nose[${PYTHON_USEDEP}]
		')
		app-misc/anki[${PYTHON_SINGLE_USEDEP}]
	)"
RDEPEND="${MY_DEPEND}"

S="${WORKDIR}/${P/m/M}"

pkg_setup() {
	# Required by DISTUTILS_SINGLE_IMPL
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	edos2unix ${PN}.desktop
}

src_test() {
	nosetests || die "Tests failed under ${EPYTHON}"
}
