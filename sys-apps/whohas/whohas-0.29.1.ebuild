# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="query multiple distributions' package archives"
HOMEPAGE="http://www.philippwesche.org/200811/whohas/intro.html"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="l10n_de"

DEPEND="dev-perl/libwww-perl
	dev-lang/perl[ithreads]
	dev-perl/forks"
RDEPEND="${DEPEND}
	sys-apps/coreutils"

src_prepare() {
	if ! use l10n_de; then
		sed -i -e '/\/de\/man/d' Makefile || die
	fi
	default
}

src_compile() {
	:
}

src_install() {
	emake PREFIX="${ED}/usr" docdir="${ED}/usr/share/doc/${PF}" install
}
