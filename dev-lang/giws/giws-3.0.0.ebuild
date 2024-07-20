# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{10..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="A wrapper generator to generate C++ mapping Java classes"
HOMEPAGE="https://github.com/opencollab/giws"
SRC_URI="https://github.com/opencollab/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/libxml2[python,${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

# TODO: src_test with "emake examples"---but need to clean up afterward!

src_install() {
	distutils-r1_src_install
	dodoc -r examples
}
