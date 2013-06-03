# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/sourcenav/sourcenav-5.2_beta2.ebuild,v 1.13 2009/12/29 13:47:33 flameeyes Exp $

EAPI=5

#inherit autotools flag-o-matic eutils toolchain-funcs fdo-mime
inherit flag-o-matic eutils toolchain-funcs fdo-mime

S="${WORKDIR}/sourcenavigator-NG${PV}"
SN="/opt/sourcenav"

DESCRIPTION="Code analysis and development tool, fork of Source-Navigator"
SRC_URI="mirror://berlios/sourcenav/sourcenavigator-NG${PV}.tar.bz2"
HOMEPAGE="http://sourcenav.berlios.de"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="amd64 ~sparc ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="x11-libs/libX11
	!dev-util/sourcenav
	x11-libs/libXdmcp
	x11-libs/libXaw
	sys-libs/glibc"

DEPEND="${RDEPEND}
	x11-proto/xproto"

src_prepare() {
	# still needed for me
	epatch "${FILESDIR}/sourcenav_tk-8.3-lastevent.patch"
}

src_configure() {
	local conf="
		--host=${CHOST}
		--prefix=${SN}
		--exec-prefix=${SN}
		--bindir=${SN}/bin
		--sbindir=${SN}/sbin
		--mandir=${SN}/share/man
		--infodir=${SN}/share/info
		--datadir=${SN}/share
		--libdir=${SN}/$(get_libdir)"

	./configure $conf # econf $conf does not work (host conflicts).
}

src_install() {
	emake DESTDIR="${D}" install

	fperms -Rf 755 "${SN}/share/doc/${P}/demos"
	dodir /etc/env.d
	echo "PATH=${SN}/bin" > "${D}"/etc/env.d/10snavigator

	make_desktop_entry \
		/opt/sourcenav/bin/snavigator \
		"Source Navigator ${PV}" \
		"/opt/sourcenav/share/bitmaps/ide_icon.xpm" \
		"Application;Development"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
