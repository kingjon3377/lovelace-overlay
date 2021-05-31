# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1

DESCRIPTION="(Fan)fiction content downloader"
HOMEPAGE="https://pypi.org/project/fiction-dl/ https://github.com/DreamCobbler/fiction-dl"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

# TODO: Download source from GH and run tests.

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64" # no ~x86 because not present in cloudscraper

DEPEND="dev-python/Dreamy-Utilities[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/PyMuPDF[${PYTHON_USEDEP}]
	dev-python/bleach[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/ebooklib[${PYTHON_USEDEP}]
	dev-python/fake-useragent[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	media-libs/opencv[python,${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/praw[${PYTHON_USEDEP}]
	dev-python/pykakasi[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]"
BDEPEND=""
