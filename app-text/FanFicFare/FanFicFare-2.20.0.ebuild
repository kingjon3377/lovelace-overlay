# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit eutils distutils-r1

DESCRIPTION="Download fanfiction from various sites in ebook form"
HOMEPAGE="https://github.com/jimmxinu/fanficfare"
SRC_URI="https://github.com/JimmXinu/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
#SRC_URI="http://fanficdownloader.googlecode.com/hg/fanficdownloader.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/beautifulsoup:4[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

# TODO: Add USE flag for calibre plugin and web-service

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
	epatch "${FILESDIR}/dwiggie-fff.patch"
	epatch "${FILESDIR}/${PN}-2.2.20-system-config.patch"
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
	cd "${T}"
	"${PYTHON}" "${S}/fanficfare/cli.py" http://archiveofourown.org/works/257191 || die
	test -f "Not Place_ but People-ao3_257191.epub" || die "Expected downloaded ebook not present"
}
