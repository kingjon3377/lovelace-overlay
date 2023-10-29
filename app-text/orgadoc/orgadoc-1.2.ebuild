# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Organizes documents from XML descriptions"
HOMEPAGE="https://www.gnu.org/software/orgadoc"
PATCH_HASH=51307a7bbec1ad0c75128ce2d0f4163d1a52b2e1
SRC_URI="mirror://gnu/orgadoc/${P}.tar.gz
	https://git.savannah.gnu.org/cgit/orgadoc.git/patch/?id=${PATCH_HASH} -> ${P}-patch-2.patch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/libxml2:2
	dev-libs/icu:=
	sys-libs/zlib"
DEPEND="${RDEPEND}
	app-text/texi2html"

PATCHES=(
	"${FILESDIR}/${P}-01_e00d268ebd3b16bc496ada8198b6921f2890e750.patch"
	"${DISTDIR}/${P}-patch-2.patch"
	"${FILESDIR}/${P}-03_16fca113d9c98a1b9216b93b3f03f852894b2e41.patch"
)

src_install() {
	dodir /usr/share/man/man1
	default
}
