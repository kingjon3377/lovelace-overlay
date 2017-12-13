# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit perl-module

DESCRIPTION="A simple parser for Makefiles"
HOMEPAGE="http://search.cpan.org/search?query=Makefile-Parser&mode=dist"
SRC_URI="mirror://cpan/authors/id/A/AG/AGENT/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/Class-Accessor
	>=dev-perl/Class-Trigger-0.14
	>=perl-gcpan/Makefile-DOM-0.004
	>=dev-perl/IPC-Run3-0.043
	dev-perl/List-MoreUtils
	dev-perl/File-Slurp
	dev-lang/perl:="
RDEPEND="${DEPEND}"

#SRC_TEST="do"
