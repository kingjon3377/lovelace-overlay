# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Utilities to save disk space"
HOMEPAGE="http://packages.debian.org/sid/perforate"
SRC_URI="mirror://debian/pool/main/p/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	default_src_unpack
	cd "${WORKDIR}" && mv -i ${PN}-1.1 ${P} || die "fixing dir name failed"
}

src_prepare() {
	epatch "${FILESDIR}"/perforate_1.2-5.diff
}

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
