# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Multi-algorithm compression"
HOMEPAGE="https://www.rkeene.org/oss/dact"
SRC_URI="https://www.rkeene.org/files/oss/${PN}/release/${P}.tar.gz"

LICENSE="|| ( LGPL-2 GPL-2 MIT )"
SLOT="0"
KEYWORDS="amd64"

DEPEND="app-arch/bzip2
	dev-libs/lzo:2
	sys-libs/zlib
	dev-libs/libmcrypt"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/uint32.patch"
	"${FILESDIR}/headers.patch"
	"${FILESDIR}/02-lzo2.patch"
	"${FILESDIR}/10-Docs--dact.1.patch"
	"${FILESDIR}/20-Makefile.in.patch"
	"${FILESDIR}/30-DESTDIR.patch"
)

# TODO: Convert to DOCS=() default_src_install
src_install() {
	emake DESTDIR="${D}" install
	dodoc Docs/*.txt AUTHORS ChangeLog README rget.txt TODO*
}
