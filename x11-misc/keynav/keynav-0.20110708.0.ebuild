# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# From sunrise. TODO: add my changes to bug #294727

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Make pointer-driven interfaces easier and faster for users to operate"
HOMEPAGE="http://www.semicomplete.com/projects/keynav/"
SRC_URI="http://semicomplete.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXinerama
	x11-libs/libXext
	x11-libs/libXtst
	x11-misc/xdotool"
DEPEND="x11-proto/xproto
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
