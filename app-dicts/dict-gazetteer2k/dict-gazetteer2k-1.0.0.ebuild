# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} )
inherit eutils python-single-r1 multilib

DESCRIPTION="Gazetteer from the 2000 census"
HOMEPAGE="http://www.census.gov/geo/www/gazetteer/places2k.html"
SRC_URI="mirror://ubuntu/pool/universe/d/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="public-domain GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="app-text/dictd"
DEPEND="${RDEPEND}
	dev-python/dictdlib[${PYTHON_USEDEP}]
	dev-python/dictclient[${PYTHON_USEDEP}]
	${PYTHON_DEPS}"

#pkg_setup() {
#	python_pkg_setup
#}

src_unpack() {
	default
	cd "${WORKDIR}"
	mv "${P}.orig" "${P}"
}

src_prepare() {
	cd "${WORKDIR}"
	epatch "${FILESDIR}/dict-gazetteer2k_1.0.0-5.2.diff"
	cd "${S}"
	sed -i -e \
		's:GzipFile("/usr/share/doc/miscfiles/na.postalcodes.gz", "rb"):open("/usr/share/misc/na.postalcodes"):' \
		states.py || die
}

src_compile() {
	python_export PYTHON
	"${PYTHON}" zipswriter.py || die
	"${PYTHON}" placeswriter.py || die
	"${PYTHON}" countieswriter.py || die
	dictzip *.dict || die
}

src_install() {
	insinto /usr/$(get_libdir)/dict
	for file in places counties zips;do
		doins gazetteer2k-${file}.dict.dz gazetteer2k-${file}.index
	done
	dodoc debian/changelog
}
