# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR="SPROUT"

inherit perl-module

DESCRIPTION="CSS style declaration class for CSS::DOM"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-perl/Clone
	dev-lang/perl:="
RDEPEND="${DEPEND}"
