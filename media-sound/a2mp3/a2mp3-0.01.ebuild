# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="program to optimize your music for your mp3-player"
HOMEPAGE="https://packages.ubuntu.com/natty/a2mp3"
SRC_URI="mirror://ubuntu/pool/universe/${PN:0:1}/${PN}/${P/-/_}.orig.tar.gz"
#	mirror://ubuntu/pool/universe/${PN:0:1}/${PN}/${P/-/_}-0ubuntu6.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

RDEPEND="app-shells/grml-shlib
	media-sound/lame
	media-sound/mp3info
	media-sound/vorbis-tools"
DEPEND="doc? ( app-text/asciidoc
	dev-libs/libxslt )"

src_compile() {
	use doc && default_src_compile
}

src_install() {
	if use doc; then
		emake DESTDIR="${D}" usrdoc="${D}/usr/share/doc/${PF}" install
	else
		dobin ${PN}
	fi
}
