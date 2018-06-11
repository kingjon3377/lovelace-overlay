# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

#inherit autotools flag-o-matic eutils toolchain-funcs xdg-utils
inherit flag-o-matic eutils toolchain-funcs xdg-utils

S="${WORKDIR}/sourcenavigator-NG${PV}"
SN="/opt/sourcenav"

DESCRIPTION="Code analysis and development tool, fork of Source-Navigator"
SRC_URI="mirror://sourceforge/sourcenav/NG${PV}/sourcenavigator-NG${PV}.tar.bz2"
HOMEPAGE="http://sourcenav.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~amd64 ~sparc ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="x11-libs/libX11
	!dev-util/sourcenav
	x11-libs/libXdmcp
	x11-libs/libXaw
	sys-libs/glibc"

DEPEND="${RDEPEND}
	base/xorg-proto"

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

	./configure $conf # econf $conf does not work (host conflicts), and eautoreconf brings worse failures
}

src_install() {
	emake -j1 DESTDIR="${D}" install

	fperms -R 755 "${SN}/share/snavigator/demos"
	dodir /etc/env.d
	echo "PATH=${SN}/bin" > "${D}"/etc/env.d/10snavigator

	make_desktop_entry \
		/opt/sourcenav/bin/snavigator \
		"Source Navigator ${PV}" \
		"/opt/sourcenav/share/bitmaps/ide_icon.xpm" \
		"Application;Development"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
