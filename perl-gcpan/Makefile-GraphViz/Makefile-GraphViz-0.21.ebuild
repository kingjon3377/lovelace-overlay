# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit perl-module

#S=${WORKDIR}/Makefile-GraphViz-0.18

DESCRIPTION="Draw building flowcharts from Makefiles using GraphViz"
HOMEPAGE="http://search.cpan.org/search?query=Makefile-GraphViz&mode=dist"
SRC_URI="mirror://cpan/authors/id/A/AG/AGENT/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/GraphViz-2.04
	>=perl-gcpan/Makefile-Parser-0.211
	dev-lang/perl:="
RDEPEND="${DEPEND}"

#SRC_TEST="do"
