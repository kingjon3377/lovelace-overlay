# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="query multiple distributions' package archives"
HOMEPAGE="http://www.philippwesche.org/200811/whohas/intro.html"
SRC_URI="http://www.philippwesche.org/200811/whohas/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="linguas_de"

DEPEND="dev-perl/libwww-perl"
RDEPEND="${DEPEND}
	sys-apps/coreutils"

src_install() {
	dobin program/whohas
	doman usr/share/man/man1/whohas.1
	use linguas_de && doman usr/share/man/de/man1/whohas.1
	dodoc Changelog intro.txt
	dohtml intro.html
	docinto html_assets
	dohtml html_assets/*
}
