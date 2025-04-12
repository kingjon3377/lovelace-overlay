# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Utilities to save disk space"
HOMEPAGE="https://packages.debian.org/sid/perforate https://perforate-linux.sourceforge.net/"
SRC_URI="mirror://debian/pool/main/p/${PN}/${P/-/_}.orig.tar.gz"

S="${WORKDIR}/${PN}-1.1"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/perforate-1.2-debian.patch
	"${FILESDIR}"/perforate-1.2-typos.patch
	"${FILESDIR}"/perforate-1.2-0003-finddup-read-files-BUFSIZ-bytes-at-a-time-Closes-449.patch
)

src_compile() {
	emake CC=$(tc-getCC) CFLAGS="${CFLAGS}"
}

src_install() {
	dobin zum finddup findstrip
	dodoc README.perforate
	doman "${FILESDIR}"/*.1
}

pkg_postinst() {
	if has_version sys-boot/lilo; then
		ewarn "If you use lilo and zum the directory where your kernel image lives,"
		ewarn "your system will become unbootable unless you run lilo again."
	fi
}
