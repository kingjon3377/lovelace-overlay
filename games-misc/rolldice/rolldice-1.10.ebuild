# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# TODO: Do we really still need eutils?
inherit eutils toolchain-funcs

DESCRIPTION="virtual dice roller"
HOMEPAGE="https://packages.debian.org/rolldice"
SRC_URI="mirror://debian/pool/main/r/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}.orig"

PATCHES=(
	"${FILESDIR}/01_remove_strip.diff"
	"${FILESDIR}/debian-changes-1.10-5.diff"
)
src_prepare() {
	default
	sed -i -e "s:/usr/games$:/usr/bin:" Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}"
}

DOCS=( README Changelog CREDITS )
