# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="libpurple plugin implementing Google Talk's 'shared status' feature"
HOMEPAGE="http://www.siorarina.net/gtalk-shared-status/"
SRC_URI="http://www.siorarina.net/heap/gss/src/autotools/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-im/pidgin"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog README )

src_install() {
	default
	prune_libtool_files --modules
}
