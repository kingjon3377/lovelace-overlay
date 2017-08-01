# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="program to optimize your music for your mp3-player"
HOMEPAGE="http://packages.ubuntu.com/natty/a2mp3"
SRC_URI="mirror://ubuntu/pool/universe/a/${PN}/${P/-/_}-0ubuntu5.tar.gz"

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
		emake DESTDIR="${D}" usrdoc="${D}/usr/share/doc/${P}" install
	else
		dobin ${PN}
	fi
}
