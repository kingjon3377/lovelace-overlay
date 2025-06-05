# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )
PYPI_NO_NORMALIZE=true
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="(Fan)fiction content downloader"
HOMEPAGE="https://pypi.org/project/fiction-dl/ https://github.com/DreamCobbler/fiction-dl"

# TODO: Download source from GH and run tests.

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64" # no ~x86 because not present in cloudscraper

DEPEND="dev-python/Dreamy-Utilities[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/bleach[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
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

# N.B. without the first patch, depends on PyMuPDF for PDF output; we patch to drop
# that feature because building PyMuPDF against a system install of mupdf has
# been failing for some time now.
PATCHES=(
	"${FILESDIR}/${P}-drop-pdf.patch"
	"${FILESDIR}/${P}-syntax-warnings.patch"
)

src_prepare() {
	sed -i -e '/opencv-python/d' -e 's@bs4@beautifulsoup4@' setup.py ${PN/-/_}.egg-info/requires.txt || die
	default
}
