# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit distutils-r1

DESCRIPTION="Download fanfiction from various sites in ebook form"
HOMEPAGE="https://github.com/jimmxinu/fanficfare"
SRC_URI="https://github.com/JimmXinu/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]
	dev-python/html2text[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/requests-file[${PYTHON_USEDEP}]
	|| ( app-arch/brotli[python,${PYTHON_USEDEP}] dev-python/brotlipy[${PYTHON_USEDEP}] )
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/cloudscraper[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

# TODO: Add USE flag for calibre plugin and web-service

PATCHES=(
	"${FILESDIR}/dwiggie-fff-3.patch"
	"${FILESDIR}/${PN}-2.2.20-system-config.patch"
)

src_prepare() {
#	edos2unix $(find . -type f -print) || die # a file has a space in it, so inline
	find . -type f \( -name \*.png -o -exec sed -i 's/\r$//' -- {} + \) || die
	cp -n "${FILESDIR}"/adapter_* "fanficfare/adapters/" || die
	sed -i -e '1s/^\xef\xbb\xbf//' fanficfare/translit.py || die
	find . -name \*.py -exec sed -i \
		-e 's/from \(\.\|\.\.\) \(import BeautifulSoup as bs\)/\2/' \
		-e 's/from \(\.\|\.\.\) \(import BeautifulSoup\)/\2/' \
		-e 's/from \.\.BeautifulSoup import/from BeautifulSoup import/' \
		{} + || die
	distutils-r1_src_prepare
}

python_install_all() {
	distutils-r1_python_install_all
	dodir /etc/fanficfare
	insinto /etc/fanficfare
	doins fanficfare/defaults.ini
	dodoc fanficfare/example.ini DESCRIPTION.rst
	dosym fanficfare /usr/bin/ffd
	dosym fanficfare /usr/bin/fff
}

python_test() {
	local expected="Not Place_ but People-ao3_257191.epub"
	cd "${T}"
	rm -f "${expected}"
	"${PYTHON}" "${S}/fanficfare/cli.py" http://archiveofourown.org/works/257191 || die
	test -f "${expected}" || die "Expected downloaded ebook not present"
}
