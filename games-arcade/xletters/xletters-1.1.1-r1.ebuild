# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Type falling words before they land"
HOMEPAGE="https://packages.debian.org/xletters"
SRC_URI="mirror://debian/pool/main/x/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

# netcat is used at runtime in xletters-duel and presumably detected at
# build-time; it is not used *in* the build.
DEPEND="net-analyzer/netcat
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXaw
	x11-libs/libXext
	x11-libs/libXt
	acct-group/gamestat"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/xletters_1.1.1-4.1.diff )

src_prepare() {
	default
	sed -i -e 's:/var/local/games/lib/xletters:/var/games/xletters:' "${S}"/Makefile.in || die
}

src_install() {
	emake DESTDIR="${D}" install
	dodir /var/games
	fperms 664 "/var/games/${PN}/scores"
	fperms g+s "/usr/bin/${PN}"
	dodoc README
}
