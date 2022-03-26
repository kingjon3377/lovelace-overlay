# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{8..10} )
inherit python-r1 readme.gentoo-r1

DESCRIPTION="CLI tool to provide quick access to current weather conditions and forecasts"
HOMEPAGE="http://fungi.yuggoth.org/weather/"
SRC_URI="http://fungi.yuggoth.org/weather/src/${P}.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="app-arch/xz-utils"
RDEPEND="${PYTHON_DEPS}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=(
	"${FILESDIR}/${PN}-2.3-fhs.patch"
)

DOC_CONTENTS="
System default config is located in '${EPREFIX}/etc/weatherrc'.

man weather and weatherrc for more info.
"

src_unpack() {
	default_src_unpack
	cd "${S}"
	unpack ./*zip
}

src_install() {
	my_install() {
		sitedir="$(python_get_sitedir)"
		insinto "${sitedir#${EPREFIX}}"
		doins "${PN}.py"
	}
	python_foreach_impl my_install

	insinto /etc
	doins ${PN}rc overrides.conf
	dobin ${PN}
	python_replicate_script "${ED}/usr/bin/${PN}"
	doman ${PN}.1 ${PN}rc.5
	insinto /usr/share/${PN}-util
	doins airports *.dbx *.txt places stations slist zctas zlist zones
	dodoc FAQ README NEWS
	python_setup
	python_optimize
	readme.gentoo_create_doc
}

pkg_postinst () {
	readme.gentoo_print_elog
}
