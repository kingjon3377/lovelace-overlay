# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{8..12} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Download fanfiction from various sites in ebook form"
HOMEPAGE="https://github.com/jimmxinu/fanficfare"
SRC_URI="https://github.com/JimmXinu/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/html2text[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/requests-file[${PYTHON_USEDEP}]
	app-arch/brotli[python,${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/cloudscraper[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
BDEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

# TODO: Add USE flag for calibre plugin

PATCHES=(
	"${FILESDIR}/dwiggie-fff-3.patch"
	"${FILESDIR}/${PN}-2.2.20-system-config.patch"
)

src_prepare() {
#	edos2unix $(find . -type f -print) || die # a file has a space in it, so inline
	find . -type f \( -name \*.png -o -exec sed -i 's/\r$//' -- {} + \) || die
	cp -n "${FILESDIR}"/adapter_* "fanficfare/adapters/" || die
	find . -name \*.py -exec sed -i \
		-e 's/from \(\.\|\.\.\) \(import BeautifulSoup as bs\)/\2/' \
		-e 's/from \(\.\|\.\.\) \(import BeautifulSoup\)/\2/' \
		-e 's/from \.\.BeautifulSoup import/from BeautifulSoup import/' \
		{} + || die
	distutils-r1_src_prepare
}

python_install_all() {
	distutils-r1_python_install_all
	insinto /etc/fanficfare
	doins fanficfare/defaults.ini
	dodoc fanficfare/example.ini DESCRIPTION.rst
	dosym fanficfare /usr/bin/fff
}

python_test() {
	epytest
	# Under Python 3.12, in PEP517 mode, currently PYTHONPATH is unset, causing the following to fail. TODO: debug
#	local expected="Not Place_ but People-ao3_257191.epub"
#	cd "${T}"
#	rm -f "${expected}"
#	"${PYTHON}" "${S}/fanficfare/cli.py" http://archiveofourown.org/works/257191 || die
#	test -f "${expected}" || die "Expected downloaded ebook not present"
}
