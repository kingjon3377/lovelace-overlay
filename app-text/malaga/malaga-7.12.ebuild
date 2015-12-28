# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Linguistic morphological programming language and toolset"
HOMEPAGE="http://home.arcor.de/bjoern-beutel/malaga/"
SRC_URI="http://home.arcor.de/bjoern-beutel/malaga/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="+gtk +doc +readline emacs"

DEPEND="dev-libs/glib:2
	gtk? ( x11-libs/gtk+:2 )
	doc? ( sys-apps/texinfo )
	readline? ( sys-libs/readline:0 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/malaga-7.12-makefile-malshow-libm.patch"
}

src_configure() {
	econf $(use_with readline) --enable-shared=yes --enable-static=no
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc CHANGES.txt INSTALL.txt README.txt
}

pkg_postinst() {
	if use emacs; then
		einfo "Add the line"
		einfo " (require 'malaga \"/usr/share/malaga/malaga.el\")"
		einfo "to ~/.emacs so the Malaga extensions will be loaded "
		einfo "automatically when you start Emacs."
	fi
}
