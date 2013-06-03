# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="iriverter is a simple video converter for portable media players"
HOMEPAGE="http://iriverter.sourceforge.net/"
SRC_URI="mirror://sourceforge/iriverter/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gcj"

# swt dep had been swt:3 , but that slot is only in java-overlay
RDEPEND="media-video/mplayer[encode,xvid]
	dev-java/swt:3.7"

DEPEND="${RDEPEND}
	sys-devel/gcc[gcj?]"

src_configure() {
	econf \
		$(use_with gcj) \
		--with-swt=`java-config -p swt-3.7`
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}
