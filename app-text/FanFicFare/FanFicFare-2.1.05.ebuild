# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1

OLD_PN=fanficdownloader

DESCRIPTION="Download fanfiction from various sites in ebook form"
HOMEPAGE="https://code.google.com/p/fanficdownloader/"
SRC_URI="http://${OLD_PN}.googlecode.com/hg-history/FFDL%20${PV}/${OLD_PN}.zip -> ${OLD_PN}-${PV}.zip"
#SRC_URI="http://fanficdownloader.googlecode.com/hg/fanficdownloader.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/beautifulsoup[${PYTHON_USEDEP}]
	dev-python/html5lib[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${OLD_PN}-${PV}"

src_prepare() {
#	rm epubmerge.py ${OLD_PN}/BeautifulSoup.py || die
	rm ${OLD_PN}/BeautifulSoup.py || die
	edos2unix $(find . -type f -print) || die
	cp "${FILESDIR}"/adapter_* "${OLD_PN}/adapters/" || die
	sed -i -e '1i\
#!/usr/bin/python' downloader.py || die
	sed -i -e '1s/^\xef\xbb\xbf//' ${OLD_PN}/translit.py || die
	find . -name \*.py -exec sed -i \
		-e 's/from \(\.\|\.\.\) \(import BeautifulSoup as bs\)/\2/' \
		-e 's/from \(\.\|\.\.\) \(import BeautifulSoup\)/\2/' \
		-e 's/from ..BeautifulSoup import/from BeautifulSoup import/' \
		{} + || die
	epatch "${FILESDIR}/dwiggie.patch"
	epatch "${FILESDIR}/${OLD_PN}-2.1-system-config.patch"
}

src_install() {
	sub_install() {
		python_domodule ${OLD_PN}
		cp -i downloader.py "${T}"/${OLD_PN} || die
		python_doscript "${T}"/${OLD_PN}
		rm -f "${T}"/${OLD_PN} || die
	}
	python_foreach_impl sub_install
	dodir /etc/${OLD_PN}
	insinto /etc/${OLD_PN}
	doins defaults.ini
	dodoc example.ini readme.txt
	dosym ${OLD_PN} /usr/bin/ffd
}

src_test() {
	python_setup
	cd "${T}"
	"${PYTHON}" "${S}/downloader.py" http://archiveofourown.org/works/257191 || die
}
