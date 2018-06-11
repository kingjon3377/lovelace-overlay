# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# From sunrise. TODO: add my changes to bug #294727. With changes from betagarden overlay.

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Move the mouse pointer with few key strokes"
HOMEPAGE="http://www.semicomplete.com/projects/keynav/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/semicomplete/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

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

src_prepare() {
	# -pg is incompatible with PIE.
	sed -i -e "s:^CFLAGS+=-pg -g:#CFLAGS+=-pg -g:" \
		-e "s:^LDFLAGS+=-pg -g:#LDFLAGS+=-pg -g:" "${S}"/Makefile || die "sed failed"
}

src_compile() {
	tc-export CC LD
	default
}

src_install() {
	dodoc README CHANGELIST
	dobin keynav

	insinto /etc
	doins keynavrc
}
