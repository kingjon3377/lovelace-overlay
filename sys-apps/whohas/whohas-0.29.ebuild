# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="query multiple distributions' package archives"
HOMEPAGE="http://www.philippwesche.org/200811/whohas/intro.html"
SRC_URI="http://www.philippwesche.org/200811/whohas/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="l10n_de"

DEPEND="dev-perl/libwww-perl
	dev-lang/perl[ithreads]"
RDEPEND="${DEPEND}
	sys-apps/coreutils"

src_install() {
	dobin program/whohas
	doman usr/share/man/man1/whohas.1
	use l10n_de && doman usr/share/man/de/man1/whohas.1
	dodoc Changelog intro.txt intro.html
	dodoc -r html_assets
}
