# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="scancode/keycode table manipulation utility"
HOMEPAGE="https://0pointer.de/lennart/projects/keyfuzz/"
SRC_URI="https://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="${DEPEND}"
BDEPEND="doc? (
		www-client/lynx
		app-text/xmltoman
	)
	dev-util/gengetopt"

src_configure() {
	econf --with-initdir=no $(use_enable doc lynx) $(use_enable doc xmltoman)
}

src_install() {
	default
	newinitd "${FILESDIR}/${P}.initd" "${PN}"
}
