# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..12} )
DISTUTILS_USE_PEP517=setuptools
EGIT_REPO_URI="https://github.com/olivierverdier/pydflatex.git"

inherit git-r3 distutils-r1

DESCRIPTION="LaTeX wrapper and log colorizer"
HOMEPAGE="https://github.com/olivierverdier/pydflatex"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-python/blessed[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

distutils_enable_tests unittest

src_prepare() {
	sed -i -e 's@blessings@blessed@' \
		requirements.txt "${PN}/latex_logger.py" "${PN}/processor.py" "test/test_output.py" || die
	default
}
