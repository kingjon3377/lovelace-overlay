# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop

DESCRIPTION="GNU spreadsheet program"
HOMEPAGE="https://www.gnu.org/software/oleo/"
SRC_URI="http://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+X +motif"

DEPEND="sys-libs/ncurses:0
	sys-devel/gettext
	sys-apps/texinfo
	X? ( x11-libs/libX11 )
	motif? ( x11-libs/motif:0
		x11-libs/xbae
		media-libs/plotutils )"
RDEPEND="${DEPEND}"

REQUIRED_USE="motif? ( X )"

PATCHES=(
	"${FILESDIR}/oleo_1.99.16-10ubuntu1.diff"
	"${FILESDIR}/destdir.patch"
	"${FILESDIR}/label.patch"
	"${FILESDIR}/update-cat-id-tbl.patch"
	"${FILESDIR}/oleorc_docs.patch"
)

src_configure() {
	local myconf
	if use motif; then
		myconf=""
	elif use X; then
		myconf="--without-motif"
	else
		myconf="--without-x"
	fi
	default_src_configure ${myconf}
	sed -i -e 's:prefix = /usr:prefix = $(DESTDIR)/usr:' po/Makefile || die "hack to avoid sandbox violation failed"
}

src_compile() {
	default_src_compile CC=$(tc-getCC) "CFLAGS=${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

DOCS=(
	AUTHORS
	FAQ
	NEWS
	THANKS
	TODO
	"${FILESDIR}/debian-changelog"
	"${FILESDIR}/ChangeLog"
	"${FILESDIR}/debian-TODO"
)

src_install() {
	default
	doman "${FILESDIR}/${PN}.1"
	# TODO: Add README* to DOCS
	dodoc README*
	dodoc -r examples
	domenu "${FILESDIR}/${PN}.desktop"
	rm -r "${D}"/usr/Oleo || die "fixing mis-installed docs failed"
}
