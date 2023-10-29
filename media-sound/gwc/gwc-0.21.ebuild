# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2 toolchain-funcs desktop

DESCRIPTION="Audio file denoiser"
HOMEPAGE="https://gwc.sourceforge.net/"
SRC_URI="mirror://sourceforge/gwc/gwc2/${PV}-11/${P}-11.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND="media-libs/libsndfile
	sci-libs/fftw:3.0
	gnome-base/libgnomeui
	gnome-base/libgnome"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}-11"

PATCHES=(
	"${FILESDIR}/gwc_0.21.05-1.2.diff"
	 "${FILESDIR}/destdir.patch"
)

src_prepare() {
	gnome2_src_prepare
}

src_compile() {
	emake CC=$(tc-getCC) CPPFLAGS="${CFLAGS}"
}

src_install() {
	gnome2_src_install DOCDIR="${D}/usr/share/doc/${PF}"
	dodoc changes
	doman debian/gnome_wave_cleaner.1
	domenu debian/gwc.desktop
}
