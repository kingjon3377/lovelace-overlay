# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_5,2_6,2_7} )
# TODO: Should probably be python-any-r1
inherit python-single-r1

DESCRIPTION="Gazetteer from the 2000 census"
HOMEPAGE="http://www.census.gov/geo/www/gazetteer/places2k.html"
SRC_URI="mirror://ubuntu/pool/universe/d/${PN}/${PN}_${PV}.orig.tar.gz"

# The Debian copyright file says the main source was downloaded from
# ${HOMEPAGE} and http://www.census.gov/ftp/pub/tiger/tms/gazetteer/allfiles.zip
# and that zips.txt was from ftp://ftp.census.gov:/pub/tiger/tms/gazetteer/zips.zip .
# Neither of those FTP paths now work.

LICENSE="public-domain GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="app-text/dictd"
DEPEND="${RDEPEND}
	dev-python/dictdlib[${PYTHON_USEDEP}]
	dev-python/dictclient[${PYTHON_USEDEP}]
	${PYTHON_DEPS}"

S="${WORKDIR}/${P}.orig"

src_prepare() {
	cp "${FILESDIR}/"*.py . || die
	default
}

pkg_setup() {
	python-single-r1_pkg_setup
}

src_compile() {
	"${PYTHON}" zipswriter.py || die
	"${PYTHON}" placeswriter.py || die
	"${PYTHON}" countieswriter.py || die
	dictzip *.dict || die
}

src_install() {
	insinto /usr/share/dictd
	for file in places counties zips;do
		doins gazetteer2k-${file}.dict.dz gazetteer2k-${file}.index
	done
	dodoc "${FILESDIR}/debian-changelog"
}
