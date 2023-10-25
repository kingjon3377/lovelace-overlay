# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} )

inherit lua-single

DESCRIPTION="Rearrange dominoes to cause a chain reaction"
HOMEPAGE="https://domino-chain.gitlab.io/"
SRC_URI="https://gitlab.com/domino-chain/domino-chain.gitlab.io/-/archive/${PV}/${PN}.gitlab.io-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

REQUIRED_USE="${LUA_REQUIRED_USE}"
DEPEND="dev-libs/boost
	dev-libs/fribidi
	${LUA_DEPS}
	media-libs/libpng
	media-libs/libsdl2
	media-libs/sdl2-image
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf
	sys-libs/zlib
	media-fonts/freefont[X]"
RDEPEND="${DEPEND}"
BDEPEND="sys-devel/gettext
	virtual/imagemagick-tools
	sys-devel/make
	virtual/pkgconfig
	media-gfx/povray
	sys-apps/sed
	app-alternatives/bzip2
	|| ( dev-util/shellcheck dev-util/shellcheck-bin )" # TODO: test? () ?

S="${WORKDIR}/${PN}.gitlab.io-${PV}"

RESTRICT="test" # TODO: ask upstream how to get them to pass

src_test() {
	mkdir -p "${T}/.local/share/${PN}/" || die
	cp -r src/levels/original "${T}/.local/share/${PN}/original"
	HOME="${T}" default
}

src_install() {
	default
	if test -d "${ED}/usr/share/doc/${PF}";then
		mv "${ED}/usr/share/doc/${PN}"/* "${ED}/usr/share/doc/${PF}"
		rmdir "${ED}/usr/share/doc/${PN}"
	else
		mv "${ED}/usr/share/doc/${PN}" "${ED}/usr/share/doc/${PF}"
	fi
}
