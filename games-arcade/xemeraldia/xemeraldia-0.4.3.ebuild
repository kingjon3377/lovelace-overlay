# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="not just another tetris clone"
HOMEPAGE="http://www.reloco.com.ar/xemeraldia/"
SRC_URI="http://www.reloco.com.ar/xemeraldia/${P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e 's:GTK_WIDGET_FLAGS(widget) & GTK_NO_WINDOW:!(gtk_widget_get_has_window(widget)):' \
		graphics.c || die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" gamesdir="/usr/bin" \
		appsdir="/usr/share/applications" pixmapsdir="/usr/share/pixmaps" install
	doman "${FILESDIR}"/${PN}.6x
	dodoc NEWS README TODO ChangeLog
	dodir "/var/games"
	touch "${D}/var/games/${PN}.scores"
	fowners "games:games" "/var/games/${PN}.scores"
	fperms 664 "/var/games/${PN}.scores"
}
