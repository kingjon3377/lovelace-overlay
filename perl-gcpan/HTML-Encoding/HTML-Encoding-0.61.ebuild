# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR="BJOERN"

inherit perl-module

DESCRIPTION="Determine encoding of HTML/XHTML documents"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-lang/perl:="
RDEPEND="${DEPEND}"
