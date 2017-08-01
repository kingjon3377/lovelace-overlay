# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit qt4-r2

DESCRIPTION="BibleMemorizer is a program to help with scripture memorization."
HOMEPAGE="http://biblememorizer.sourceforge.net"
SRC_URI="mirror://sourceforge/biblememorizer/${P}.tar.gz"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="+sword"

DEPEND="dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qt3support:4
		sword? ( >=app-text/sword-1.5.8 )"
RDEPEND="${DEPEND}"

src_prepare() {
	# we want to run qmake ourselves
	sed -i -e 's:^qmake:#qmake:' configure || die "sed failed"
	# fix multilib
	sed -i -e "s:/lib/:/$(get_libdir)/:" plugins/plugin_vars || die "sed failed"
}

src_configure() {
	export PATH="/usr/bin:$PATH"
	local SWORD_CONFIG
	if use sword; then
		SWORD_CONFIG=""
	else
		SWORD_CONFIG="--disable-sword"
	fi
	econf ${SWORD_CONFIG}
	qt4-r2_src_configure
}

src_compile() {
	#Fix sandbox issues
#	addwrite "${QTDIR}/etc/settings"
	emake
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	dodoc AUTHORS CREDITS README TODO
	insinto /usr/share/icons/hicolor/16x16/apps
	newins icons/bmemicon-16x16.png biblememorizer.png
	insinto /usr/share/icons/hicolor/48x48/apps
	newins icons/bmemicon-48x48.png biblememorizer.png
	insinto /usr/share/applications
	doins biblememorizer.desktop
}
