# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2 toolchain-funcs autotools

DESCRIPTION="Audio file denoiser"
HOMEPAGE="http://gwc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}2/${PV}/gtk-wave-cleaner-${PV}-01.tar.gz
	mirror://debian/pool/main/g/${PN}/${PN}_${PV}.01-1.debian.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-libs/libsndfile
	sci-libs/fftw:3.0
	x11-libs/gtk+:2
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

S="${WORKDIR}/gtk-wave-cleaner-${PV}-01"

src_prepare() {
	mv "${WORKDIR}/debian" "${S}/debian" || die
	sed -i -e 's@README$@README TODO Changelog@' debian/patches/02-no_extra_docs.patch || die
	while read -r file;do
		eapply "debian/patches/${file}"
	done < debian/patches/series
	default
	eautoreconf
}

src_compile() {
	emake CC=$(tc-getCC) CPPFLAGS="${CFLAGS}"
}

src_install() {
	gnome2_src_install DOCDIR="${D}/usr/share/doc/${PF}"
	doman debian/gtk-wave-cleaner.1
}
