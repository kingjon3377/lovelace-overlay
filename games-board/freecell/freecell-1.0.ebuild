# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit games

DESCRIPTION="Console version of freecell"
HOMEPAGE="http://www.linusakesson.net/software/freecell.php"
SRC_URI="http://www.linusakesson.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install
}
