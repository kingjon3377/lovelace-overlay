# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2 toolchain-funcs eutils meson

DESCRIPTION="Private digital diary"
HOMEPAGE="http://lifeograph.sourceforge.net"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV/1.1/1}/+download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-cpp/gtkmm:3.0
	dev-cpp/gconfmm
	>=app-text/enchant-2.0
	app-text/gtkspell:3
	dev-libs/libgcrypt:0"
RDEPEND="${DEPEND}"

DOCS=( README NEWS AUTHORS )

S="${WORKDIR}"

src_install() {
	default
	die "Is everything installed?"
	#doman lifeograph.1
	#domenu lifeograph.desktop
}
