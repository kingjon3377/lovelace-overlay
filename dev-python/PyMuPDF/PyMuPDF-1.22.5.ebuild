# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYPI_NO_NORMALIZE=true
PYTHON_COMPAT=( python3_{9..11} )
inherit distutils-r1 pypi

DESCRIPTION="Python bindings to app-text/mupdf"
HOMEPAGE="https://pypi.org/project/PyMuPDF/ https://github.com/pymupdf/PyMuPDF"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=app-text/mupdf-$(ver_cut 0-2)*:="
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i -e '/mupdf-third/d' setup.py || die
	default
}

python_configure() {
	export PYMUPDF_SETUP_MUPDF_BUILD= PYMUPDF_SETUP_MUPDF_TGZ=
	default
}

# Two tests fail (with below python_test; distutils_enable_tests pytest leads
# to every test failing due to circular module dependencies), one with
# "unsupported font" even when the font in question is installed and the other
# something less clear
RESTRICT="test"

python_test() {
	distutils_install_for_testing
	cd tests || die
	epytest
}
