# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="libpurple plugin implementing Google Talk's 'shared status' feature"
HOMEPAGE="http://www.siorarina.net/gtalk-shared-status/"
SRC_URI="http://www.siorarina.net/gss/src/autotools/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-im/pidgin"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	prune_libtool_files --modules
	dodoc ChangeLog README
}
