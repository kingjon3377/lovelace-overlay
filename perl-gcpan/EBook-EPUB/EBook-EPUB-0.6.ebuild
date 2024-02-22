# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# This ebuild generated by g-cpan 0.17.0

EAPI=8

DIST_AUTHOR="OTY"

inherit perl-module

DESCRIPTION="module for generating EPUB documents"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-perl/XML-Writer
	>=dev-perl/Moose-2.201.500
	dev-perl/Archive-Zip
	dev-perl/Data-UUID"