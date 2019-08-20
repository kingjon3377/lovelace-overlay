# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Might be compatible with Python 3.3 ...
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A wrapper generator to generate C++ mapping Java classes"
HOMEPAGE="https://github.com/opencollab/giws"
SRC_URI="http://forge.scilab.org/index.php/p/${PN}/downloads/get/${P}.tar.gz"

LICENSE="CeCILL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-libs/libxml2[python,${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_install() {
	distutils-r1_src_install
	dodoc -r examples
}
