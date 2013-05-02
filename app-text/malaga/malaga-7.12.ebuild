# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

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
	readline? ( sys-libs/readline )"
RDEPEND="${DEPEND}"

src_configure() {
	econf $(use_with readline )
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc CHANGES.txt INSTALL.txt README.txt
}

pkg_postinst() {
	einfo "If you are using Emacs, add the line"
	einfo "	(require 'malaga \".../malaga-7.5/malaga.el\")"
	einfo "to the file \".emacs\" in your home directory, "
	einfo "so the Malaga extensions will be loaded automatically "
	einfo "if you are starting Emacs."
	einfo "	(Use the absolute path for \".../malaga-7.5\".)"
}
