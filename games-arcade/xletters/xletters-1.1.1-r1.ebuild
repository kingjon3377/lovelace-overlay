# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit games

DESCRIPTION="Type falling words before they land"
HOMEPAGE="https://packages.debian.org/xletters"
SRC_URI="mirror://debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=" || ( net-analyzer/netcat >=net-analyzer/netcat6-1.0-r2 )
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXaw
	x11-libs/libXext
	x11-libs/libXt"
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${WORKDIR}"
	epatch "${FILESDIR}"/xletters_1.1.1-4.1.diff
	sed -i -e 's:/var/local/games/lib/xletters:/var/games/xletters:' "${S}"/Makefile.in || die
}

src_install() {
	emake DESTDIR="${D}" install
	dodir /var/games
	fperms 664 "/var/games/xletters/scores"
	fperms g+s "/usr/games/bin/xletters"
	dodoc README
}
