# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# This ebuild generated by g-cpan 0.16.0

EAPI=5

MODULE_AUTHOR="BJOERN"

inherit perl-module

DESCRIPTION="XS Interface to the OpenSP SGML/XML Parser"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-perl/Test-Exception
	dev-perl/Class-Accessor
	dev-lang/perl"
RDEPEND="${DEPEND}"
