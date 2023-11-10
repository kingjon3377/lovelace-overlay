# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# From sunrise. TODO: add my changes to bug #294727. With changes from betagarden overlay.

EAPI=7

inherit toolchain-funcs

DEB_REV=~git6505bd0d
DEB_PATCH=-3

DESCRIPTION="Move the mouse pointer with few key strokes"
HOMEPAGE="https://www.semicomplete.com/projects/keynav/"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}${DEB_REV}.orig.tar.gz
	mirror://debian/pool/main/${PN:0:1}/${PN}/${PN}_${PV}${DEB_REV}${DEB_PATCH}.debian.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	x11-libs/cairo[X]
	x11-libs/libXinerama
	dev-libs/glib:2
	x11-libs/libXext
	x11-libs/libXtst
	x11-libs/libX11
	x11-misc/xdotool"
DEPEND="x11-base/xorg-proto
	${RDEPEND}"
BDEPEND="app-arch/xz-utils"

S=${WORKDIR}/${PN}-master

PATCHES=(
	"${FILESDIR}/remove_debianisms.patch"
)

src_prepare() {
	while read -r patch;do
		eapply "../debian/patches/${patch}"
	done < ../debian/patches/series
	sed -i -e "s@dpkg-parsechangelog -SVersion@echo '$PV'@" version.sh || die
	default
}

src_compile() {
	tc-export CC LD
	default CFLAGS="${CFLAGS} ${CPPFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dodoc README CHANGELIST
	dobin keynav

	insinto /etc
	doins keynavrc
}
