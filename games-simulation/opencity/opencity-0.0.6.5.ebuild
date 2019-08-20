# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN=opencity
MY_P=${MY_PN}-${PV}stable

DESCRIPTION="Another city simulator written with OpenGL & SDL"
HOMEPAGE="http://opencity.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opengl
		media-libs/libsdl
		media-libs/sdl-mixer
		media-libs/sdl-ttf
		media-libs/sdl-image"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e 's#^docsdir = $(datadir)/doc/$(PACKAGE)#docsdir = @docdir@#' docs/Makefile.in || die
	default
}
