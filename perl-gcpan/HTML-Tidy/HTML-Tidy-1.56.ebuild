# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR="PETDANCE"

inherit perl-module

DESCRIPTION="(X)HTML validation in a Perl object"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-lang/perl:=
	app-text/tidyp"
