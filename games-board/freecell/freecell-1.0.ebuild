# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Console version of freecell"
HOMEPAGE="http://www.linusakesson.net/software/freecell.php"
SRC_URI="http://www.linusakesson.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

# TODO: Isn't this basically default_src_install?
src_install() {
	emake DESTDIR="${D}" install
}
