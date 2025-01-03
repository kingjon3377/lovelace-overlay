# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="Js2Py"
PYTHON_COMPAT=( python3_{9..13} )

inherit distutils-r1 pypi

DESCRIPTION="JavaScript to Python Translator & JavaScript interpreter in Python"
HOMEPAGE="http://piter.io/projects/js2py/
	https://github.com/PiotrDabkowski/Js2Py/
	https://pypi.org/project/Js2Py/"
SRC_URI="${SRC_URI} https://patch-diff.githubusercontent.com/raw/PiotrDabkowski/Js2Py/pull/327.patch -> ${P}-python3_12.patch"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~hppa ~mips ~ppc ~ppc64 ~s390 ~sparc x86"

RDEPEND="
	>=dev-python/pyjsparser-2.5.1[${PYTHON_USEDEP}]
	>=dev-python/tzlocal-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
"

PATCHES=( "${DISTDIR}/${P}-python3_12.patch" )

python_test() {
	pushd ./tests >/dev/null || die

	# Tests require "node_failed.txt" file where the logs are kept
	if [[ -f ./node_failed.txt ]] ; then
		rm ./node_failed.txt || die
	fi

	touch ./node_failed.txt || die
	"${EPYTHON}" ./run.py || die "tests failed with ${EPYTHON}"

	popd >/dev/null || die
}
