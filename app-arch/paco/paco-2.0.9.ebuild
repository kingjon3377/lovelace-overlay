# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bash-completion-r1

DESCRIPTION="Paco is a source code package organizer"
HOMEPAGE="http://paco.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+gtk nls"

RDEPEND="gtk? ( >=dev-cpp/gtkmm-2.8 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_configure() {
	flags=""
	use gtk || flags="${flags} --disable-gpaco"
	econf ${flags}
}

src_install() {
	# FIXME: Why not emake?
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog README
	newbashcomp scripts/paco_bash_completion paco
}
