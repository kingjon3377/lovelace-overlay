# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="GOPchop is a tool for losslessly cutting and merging hardware-encoded MPEG2 video files"

HOMEPAGE="http://gopchop.sourceforge.net/"
SRC_URI="mirror://sourceforge/gopchop/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="sdl"

DEPEND=">=media-libs/libmpeg2-0.4.0
		sdl? ( media-libs/libsdl )
		=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_enable sdl) --with-x
}

src_compile() {
	emake prefix="/usr"
}

src_install() {
	# FIXME: Why can't we use emake?
	make DESTDIR="${D}" install || die

	# TODO: Can we use the dosym trick here?
	# Fixup images so the app can find them
	mv "${D}/usr/share/pixmaps/gopchop/"* \
		"${D}/usr/share/pixmaps/" -v || die
	rm -rf "${D}/usr/share/pixmaps/gopchop"

	dodoc README ChangeLog AUTHORS TODO
	make_desktop_entry gopchop "GOPchop" gopchop.png AudioVideo
}
