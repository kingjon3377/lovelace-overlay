# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="Library for unpacking MobiPocket files"
HOMEPAGE="https://github.com/iscc/mobi https://pypi.org/project/mobi/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/loguru[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/mobi-0.3.3-bump-loguru-827551df53efa4a9ec1f3d8f5e67b3be10e9f7e2.patch" )

python_prepare_all() {
	sed -i -e 's@^\([ 	]*print\)[ 	]*\(".*\)@\1(\2)@' \
		-e 's@^\([ 	]*except [^,]*\), \(.*\)@\1 as \2@' \
		mobi/mobiml2xhtml.py || die
	distutils-r1_python_prepare_all
}
