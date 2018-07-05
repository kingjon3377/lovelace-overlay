# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Analyze system logs to find problems"
HOMEPAGE="http://frakir.org/~morty/lue/log_analysis.html"
SRC_URI="http://frakir.org/~morty/lue/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl
	dev-lang/tk:="
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/separate_rules.patch" \
		"${FILESDIR}/${P}-pod2man.patch"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc NEWS README TODO README.long
}
