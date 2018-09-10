# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR="AGENT"

inherit perl-module

DESCRIPTION="Draw building flowcharts from Makefiles using GraphViz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 x86"

DEPEND=">=dev-perl/GraphViz-2.04
	>=perl-gcpan/Makefile-Parser-0.211
	dev-lang/perl:="
RDEPEND="${DEPEND}"
