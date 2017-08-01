# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils wxwidgets

DESCRIPTION="A tool that allows you to create, manipulate and study graphs"
HOMEPAGE="http://graph.seul.org/"
SRC_URI="http://graph.seul.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="nls"

# Need to depend on the slot we specify below; it doesn't appear to really care
# which, but Portage has to.
RDEPEND=">=x11-libs/wxGTK-2.6.1:2.8
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	sys-devel/flex
	sys-devel/bison"

pkg_setup() {
	export WX_GTK_VER="2.8"
	need-wxwidgets gtk2
}

src_prepare() {
	epatch "${FILESDIR}/sandbox.patch" "${FILESDIR}/wxbump.patch"
}

src_configure() {
	econf $(use_enable nls) $(use_enable nls langdialog) --with-wx-config="${WX_CONFIG}"
}

src_install() {
	einstall DESTDIR="${D}"
	dodoc README TODO CREDITS FeatureLog
}
