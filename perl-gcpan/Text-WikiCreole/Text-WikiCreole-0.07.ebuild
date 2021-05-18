# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="JBURNETT"

inherit perl-module

DESCRIPTION="Convert Wiki Creole 1.0 markup to XHTML"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl:="
RDEPEND="${DEPEND}"
