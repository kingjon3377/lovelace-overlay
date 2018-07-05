# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs

DESCRIPTION="Utilities to save disk space"
HOMEPAGE="https://packages.debian.org/sid/perforate http://perforate-linux.sourceforge.net/"
SRC_URI="mirror://debian/pool/main/p/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-1.1"

PATCHES=(
	"${FILESDIR}"/perforate_1.2-5.diff
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
