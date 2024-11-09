# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_1{1..3} )

inherit distutils-r1 pypi

DESCRIPTION="Unofficial ArchiveOfOurOwn (AO3) API"
HOMEPAGE="https://github.com/ArmindoFlores/ao3_api
	https://pypi.org/project/ao3-api/"
# Not using PyPI tarball because it omits requirements.txt
SRC_URI="https://github.com/ArmindoFlores/${PN/-/_}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

PATCHES=( "${FILESDIR}/85.patch" )

# No tests
RESTRICT=test
