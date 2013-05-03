# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# This ebuild generated by g-cpan 0.16.0

EAPI="2"

MODULE_AUTHOR="SCOP"

inherit perl-module

DESCRIPTION="The W3C Link Checker"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-perl/URI
	dev-perl/Net-IP
	perl-gcpan/CSS-DOM
	dev-perl/Encode-Locale
	>=dev-perl/config-general-2.500.0
	dev-perl/HTML-Parser
	>=dev-perl/TermReadKey-2.300.0
	>=dev-perl/libwww-perl-6.40.0
	dev-perl/HTTP-Message
	dev-perl/HTTP-Cookies
	>=dev-perl/Net-HTTP-6.30.0
	dev-lang/perl"
