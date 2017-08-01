# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit toolchain-funcs eutils multilib

DESCRIPTION="Multi-algorithm compression"
HOMEPAGE="http://www.rkeene.org/oss/dact"
SRC_URI="http://www.rkeene.org/files/oss/${PN}/release/${P}.tar.gz"

LICENSE="|| ( LGPL-2 GPL-2 MIT )"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="app-arch/bzip2
	dev-libs/lzo:2
	sys-libs/zlib
	dev-libs/libmcrypt"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/uint32.patch" "${FILESDIR}/headers.patch" "${FILESDIR}"/[0-9]*.patch
}

src_configure() {
	# FIXME: Why is it necessary to set the prefix to inside the staging area in
	# the configure phase?
	CC=$(tc-getCC) CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" econf "--prefix=${D}" "--mandir=${D}/usr/share/man" \
		"--exec-prefix=${D}/usr" "--datadir=${D}/usr/$(get_libdir)" \
		"--libdir=${D}/usr/$(get_libdir)/dact" "--sysconfdir=${D}/etc"
}

src_compile() {
	emake CC=$(tc-getCC) LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc Docs/*.txt AUTHORS ChangeLog README rget.txt TODO*
}
