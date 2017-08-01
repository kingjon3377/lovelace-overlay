# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="open source interactive height field generation and manipulation program"
HOMEPAGE="http://code.google.com/p/terraform"
SRC_URI="http://${PN}.googlecode.com/files/${PN}-src-${PV}.tgz"
IUSE=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

S="${WORKDIR}/${PN}"

DEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	dev-libs/libxml2
	gnome-base/libglade:2.0
	gnome-base/libgnome
	gnome-base/libgnomeui
	gnome-base/libgnomeprint
	gnome-base/libgnomeprintui
	"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${PV}-desktop-links.patch"
	sed -i -e \
		"s:datadir = @prefix@/doc/terraform:datadir = @datarootdir@/doc/${PF}:"\
		docs/Makefile.in || die "sed failed"
}

src_install() {
	# FIXME: Why not emake?
	make install "DESTDIR=${D}" || die "install failed!"

	doicon pixmaps/terraform_logo.xpm
	make_desktop_entry \
			terraform \
			Terrafrom \
			terraform_logo \
			3DGraphics
}
