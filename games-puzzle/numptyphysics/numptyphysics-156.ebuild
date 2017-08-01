# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit games subversion autotools

ESVN_REPO_URI="https://vcs.maemo.org/svn/numptyphysics/trunk"
if [[ "$PV" != "9999" ]] ; then
	ESVN_REVISION="$PV"
fi

DESCRIPTION="Drawing puzzle game in the spirit of Crayon Physics using the same Box2D engine"
HOMEPAGE="http://numptyphysics.garage.maemo.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image[png]
	media-libs/sdl-ttf
	x11-libs/libX11
	dev-libs/box2d
	sys-libs/zlib"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch ${FILESDIR}/"${P}-ownbox2d.patch"
	sed -i -e "s:/usr/share/numptyphysics:"${GAMES_DATADIR}"/"${PN}"/:g" -i Config.h || die 'sed failed'
	eautoreconf
}

src_configure() {
	egamesconf --disable-hildon
}

src_install() {
	emake DESTDIR="${D}" install
	doicon data/icon64/${PN}.png
	make_desktop_entry "${PN}" "${PN}"
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_postinst
}
