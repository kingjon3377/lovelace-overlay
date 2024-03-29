# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="BJOERN"

inherit perl-module

DESCRIPTION="Determine encoding of HTML/XHTML documents"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-perl/libwww-perl
	dev-perl/HTML-Parser
	dev-lang/perl:="
RDEPEND="${DEPEND}"
