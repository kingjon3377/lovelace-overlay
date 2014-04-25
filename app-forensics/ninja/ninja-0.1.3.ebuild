# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Privilege escalation detection system for GNU/Linux"
HOMEPAGE="http://forkbomb.org/ninja"
SRC_URI="http://forkbomb.org/${PN}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}/usr/sbin" MANDIR="${D}/usr/share/man/man8" \
		ETCDIR="${D}/etc/ninja" install
}

pkg_postinst() {
	ewarn "This needs major configuration to adapt it to Gentoo, including"
	ewarn "adapting Debian's init script."
}
