# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

DESCRIPTION="task list manager written in Gtk2-Perl"
HOMEPAGE="http://home.arcor.de/kaffeetisch/odot.html"
SRC_URI="http://home.arcor.de/kaffeetisch/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-perl/Gtk2
	dev-perl/DateTime
	dev-perl/XML-Parser
	dev-perl/DBI"
RDEPEND="${DEPEND}"

src_install() {
	emake PREFIX="${D}/usr" install
	dodoc ChangeLog NEWS README
}
