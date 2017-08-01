# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# This ebuild generated by g-cpan 0.15.0

EAPI=5

inherit perl-module

DESCRIPTION="Simple DOM parser for Makefiles"
HOMEPAGE="http://search.cpan.org/search?query=Makefile-DOM&mode=dist"
SRC_URI="mirror://cpan/authors/id/A/AG/AGENT/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Params-Util
	>=dev-perl/Clone-0.31
	dev-perl/List-MoreUtils
	dev-lang/perl:="
RDEPEND="${DEPEND}"

SRC_TEST="do"
