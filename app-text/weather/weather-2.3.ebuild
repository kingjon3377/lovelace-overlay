# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6,7} )
inherit python-r1

DESCRIPTION="CLI tool to provide quick access to current weather conditions and forecasts"
HOMEPAGE="http://fungi.yuggoth.org/weather/"
SRC_URI="http://fungi.yuggoth.org/weather/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES=(
	"${FILESDIR}/${P}-fhs.patch"
	"${FILESDIR}/${P}-py3k-decompress.patch"
)

src_unpack() {
	default_src_unpack
	cd "${S}"
	unpack ./*zip ./*tar
}

src_install() {
	my_install() {
		insinto "$(python_get_sitedir)"
		doins "${PN}.py"
	}
	python_foreach_impl my_install

	insinto /etc
	doins ${PN}rc overrides.conf
	dobin ${PN}
	python_replicate_script "${ED}/usr/bin/${PN}"
	doman ${PN}.1 ${PN}rc.5
	insinto /usr/share/${PN}-util
	doins airports *.dbx *.txt metar.tbl places stations slist zctas zlist zones
	doins -r zonecatalog.curr
	dodoc FAQ README NEWS
}

pkg_postinst () {
	echo
	einfo "System default config is located in /etc/weatherrc."
	einfo "man weather and weatherrc for more info."
	echo
}
