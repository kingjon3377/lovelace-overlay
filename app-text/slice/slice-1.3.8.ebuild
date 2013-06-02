# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="Extract out pre-defined slices of an ASCII file"
HOMEPAGE="ftp://ftp.ossp.org/pkg/tool/slice/"
SRC_URI="ftp://ftp.ossp.org/pkg/tool/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-perl/Bit-Vector"
RDEPEND="${DEPEND}"

src_prepare() {
	cd "${WORKDIR}" && epatch "${FILESDIR}"/slice_1.3.8-10.diff
	cd "${S}" && epatch debian/patches/*.diff
}

src_configure() {
	CFLAGS="${CFLAGS}" CC=$(tc-getCC) econf
}

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	dodir /usr/$(get_libdir)
	emake DESTDIR="${D}" prefix="${D}/usr" libdir="${D}"/usr/$(get_libdir) \
		mandir="${D}/usr/share/man" install
	dodoc ChangeLog
}
