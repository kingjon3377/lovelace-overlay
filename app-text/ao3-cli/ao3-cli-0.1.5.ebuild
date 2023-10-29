# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 pypi

DESCRIPTION="Download ebooks from ArchiveOfOurOwn.org"
HOMEPAGE="https://github.com/arzkar/ao3-cli https://pypi.org/project/ao3-cli/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${PYTHON_DEPS}
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/idna[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	>=dev-python/loguru-0.6.0[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
