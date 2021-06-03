# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..9} )
DISTUTILS_USE_SETUPTOOLS="pyproject.toml"
inherit distutils-r1

DESCRIPTION="Library for unpacking MobiPocket files"
HOMEPAGE="https://github.com/iscc/mobi https://pypi.org/project/mobi/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="dev-python/loguru[${PYTHON_USEDEP}]"
BDEPEND=""

python_prepare_all() {
	sed -i -e 's@^\([ 	]*print\)[ 	]*\(".*\)@\1(\2)@' \
		-e 's@^\([ 	]*except [^,]*\), \(.*\)@\1 as \2@' \
		mobi/mobiml2xhtml.py || die
	distutils-r1_python_prepare_all
}
