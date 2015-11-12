# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools

DESCRIPTION="A GTK+ logbook editor"
HOMEPAGE="http://packages.debian.org/source/sid/notebook"
SRC_URI="mirror://debian/pool/main/n/notebook/notebook_0.2rel.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="gnome-base/gconf
	gnome-base/libglade:2.0
	gnome-base/libgnomeui
	x11-libs/gtk+:2
	gnome-base/gvfs"
RDEPEND="${DEPEND}"

S="${WORKDIR}/notebook-0.2rel"

src_prepare() {
	cd "${WORKDIR}" && epatch "${FILESDIR}/notebook_0.2rel-2.1.diff"
	cd "${S}" && epatch debian/patches/imp-conv-pointers.patch "${FILESDIR}/gettext.patch"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
	doman debian/notebook-gtk2.1
}
