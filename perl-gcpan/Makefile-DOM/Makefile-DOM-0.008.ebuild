# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR="AGENT"

inherit perl-module

DESCRIPTION="Simple DOM parser for Makefiles"

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
