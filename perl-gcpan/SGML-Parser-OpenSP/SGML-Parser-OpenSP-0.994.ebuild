# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="BJOERN"

inherit perl-module

DESCRIPTION="XS Interface to the OpenSP SGML/XML Parser"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-perl/Test-Exception
	dev-perl/Class-Accessor
	dev-lang/perl:=
	app-text/opensp"
RDEPEND="${DEPEND}"
