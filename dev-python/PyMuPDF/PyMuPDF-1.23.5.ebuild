# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYPI_NO_NORMALIZE=true
PYTHON_COMPAT=( python3_{9..12} )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python bindings to app-text/mupdf"
HOMEPAGE="https://pypi.org/project/PyMuPDF/ https://github.com/pymupdf/PyMuPDF"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=app-text/mupdf-$(ver_cut 0-2)*:="
RDEPEND="${DEPEND}"
BDEPEND=""

python_configure() {
	export PYMUPDF_SETUP_MUPDF_BUILD= PYMUPDF_SETUP_MUPDF_TGZ= PYMUPDF_SETUP_MUPDF_THIRD=0
	default
}

# Two tests fail (in 1.21.1?, with below python_test; distutils_enable_tests
# pytest leads to every test failing due to circular module dependencies), one
# with "unsupported font" even when the font in question is installed and the
# other something less clear
RESTRICT="test"

python_test() {
	distutils_install_for_testing
	cd tests || die
	epytest
}
