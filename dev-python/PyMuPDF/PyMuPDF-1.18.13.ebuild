# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="Python bindings to app-text/mupdf"
HOMEPAGE="https://pypi.org/project/PyMuPDF/ https://github.com/pymupdf/PyMuPDF"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="=app-text/mupdf-$(ver_cut 0-2)*"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i -e '/third/d' setup.py || die
	default
}

# Tests aren't included in PyPI tarball

#distutils_enable_tests pytest

#python_test() {
	#distutils_install_for_testing
	#cd test || die
	#epytest
#}
