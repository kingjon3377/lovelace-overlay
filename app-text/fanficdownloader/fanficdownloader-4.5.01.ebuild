# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit eutils python-r1

DESCRIPTION="Download fanfiction from various sites in ebook form"
HOMEPAGE="https://code.google.com/p/fanficdownloader/"
SRC_URI="http://fanficdownloader.googlecode.com/hg/fanficdownloader.zip -> ${P}.zip"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	app-arch/unzip"

#S="${WORKDIR}/${PN}-4.4.94"

src_prepare() {
#	rm epubmerge.py ${PN}/BeautifulSoup.py || die
	rm ${PN}/BeautifulSoup.py || die
	edos2unix $(find . -type f -print) || die
	cp "${FILESDIR}"/adapter_* "${PN}/adapters/" || die
	sed -i -e '1i\
#!/usr/bin/python' downloader.py || die
	sed -i -e '1s/^\xef\xbb\xbf//' ${PN}/translit.py || die
	find . -name \*.py -exec sed -i -e \
		's/from \(\.\|\.\.\) \(import BeautifulSoup as bs\)/\2/' {} + || die
	epatch "${FILESDIR}/dwiggie.patch"
	epatch "${FILESDIR}/system-config.patch"
}

src_install() {
	sub_install() {
		python_domodule ${PN}
		cp -i downloader.py "${T}"/${PN} || die
		python_doscript "${T}"/${PN}
		rm -f "${T}"/${PN} || die
	}
	python_foreach_impl sub_install
	dodir /etc/${PN}
	insinto /etc/${PN}
	doins defaults.ini
	dodoc example.ini readme.txt
	dosym ${PN} /usr/bin/ffd
}

src_test() {
	python_export_best
	cd "${T}"
	"${PYTHON}" "${S}/downloader.py" http://archiveofourown.org/works/257191 || die
}
