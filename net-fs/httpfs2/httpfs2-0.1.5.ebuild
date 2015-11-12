# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Access Web sites as a FUSE filesystem"
HOMEPAGE="http://sourceforge.net/projects/httpfs"
SRC_URI="mirror://sourceforge/httpfs/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="sys-fs/fuse
	net-libs/gnutls"
DEPEND="${RDEPEND}
	app-text/asciidoc
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/remove_debianisms.patch"
}

src_compile() {
	default
	[[ -f ${PN}.1 ]] || emake ${PN}.1
}

src_install() {
	doman *.1
	dobin ${PN} ${PN}-ssl ${PN}-mt ${PN}-ssl-mt
}
