# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Extract out pre-defined slices of an ASCII file"
HOMEPAGE="ftp://ftp.ossp.org/pkg/tool/slice/"
SRC_URI="https://www.mirrorservice.org/sites/ftp.ossp.org/pkg/tool/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-perl/Bit-Vector"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply "${FILESDIR}"/slice_1.3.8-10.diff
	eapply debian/patches/*.diff
	eapply_user
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
