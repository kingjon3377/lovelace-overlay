# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Peter's Tetris"
HOMEPAGE="https://packages.debian.org/src:petris"
SRC_URI="mirror://debian/pool/main/p/petris/${PN}_${PV}.orig.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/ncurses:0
	dev-libs/boost
	acct-group/gamestat"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/use-variables-in-Makefile.patch"
	"${FILESDIR}/fix-highscore-location.patch"
	"${FILESDIR}/fix-highscore-string-handling.patch"
	"${FILESDIR}/fix-initialisation-and-error-handling.patch"
)

src_compile() {
	local libs
	if has_version 'sys-libs/ncurses[tinfo]';then
		libs="-lncurses -ltinfo"
	else
		libs="-lncurses"
	fi
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LIBS="${libs} ${LDFLAGS}"
}

src_install() {
	dobin ${PN}
	doman ${PN}.6
	dodoc CHANGELOG README
	dodir /var/games
	touch "${D}/var/games/petris.scores"
	fowners ":gamestat" /var/games/petris.scores
	fperms 0664 /var/games/petris.scores
	insinto /usr/share/pixmaps
	doins "${FILESDIR}/${PN}-icon.xpm"
	insinto /usr/share/icons/hicolor/128x128/apps
	doins "${FILESDIR}/${PN}-icon.png"
	insinto /usr/share/applications
	doins "${FILESDIR}/${PN}.desktop"
}
