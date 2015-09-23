# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Analyze system logs to find problems"
HOMEPAGE="http://userpages.umbc.edu/~mabzug1/log_analysis.html"
SRC_URI="http://userpages.umbc.edu/~mabzug1/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl
	dev-lang/tk:="
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/separate_rules.patch"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc NEWS README TODO README.long
}
