# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit rpm autotools desktop python-r1

DESCRIPTION="NaturalChimie clone written with clanlib"
HOMEPAGE="http://www.openalchemist.com/"
SRC_URI="https://kojipkgs.fedoraproject.org/packages/${PN}/${PV}/32.fc33/src/${P}-32.fc33.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-games/clanlib:2.3[X,opengl,vorbis,sound]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	media-libs/fontconfig
	media-libs/freetype
	virtual/jpeg
	media-libs/libpng
	sys-libs/zlib
	x11-themes/hicolor-icon-theme"
BDEPEND="virtual/pkgconfig"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-cl23.patch"
	"${FILESDIR}/${P}-title-xml.patch"
	"${FILESDIR}/${P}-py3_gtk3.patch"
	"${FILESDIR}/${P}-gentoo.patch"
)

S=${WORKDIR}/${P}-src

DOCS=( NEWS README TODO ChangeLog )

src_prepare() {
	default
	eautoreconf
}

src_install() {
	dobin build/${PN} ${PN}-config

	insinto /usr/share/${PN}
	doins -r data skins

	dodoc ${DOCS} || die "dodoc failed"

	newicon data/logo.png ${PN}.png
	newicon data/logo_svg.svg ${PN}.svg
	make_desktop_entry ${PN} OpenAlchemist ${PN}
	insinto /usr/share/appdata
	doins "${FILESDIR}/${PN}.appdata.xml"
}
