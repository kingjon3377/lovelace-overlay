# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

MODULE_AUTHOR="JJDG"

inherit perl-module

DESCRIPTION="WWW link verifier"
HOMEPAGE="http://degraaff.org/checkbot/ https://sourceforge.net/projects/checkbot/"
SRC_URI="mirror://cpan/authors/id/J/JJ/JJDG/${P}.tar.gz" # should be supplied by eclass, but isn't in EAPI 6 for some reason

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64"
IUSE="mail +ssl"

DEPEND="dev-perl/libwww-perl
	dev-perl/URI
	dev-perl/HTML-Parser
	virtual/perl-MIME-Base64
	virtual/perl-Digest-MD5
	mail? ( dev-perl/MailTools )
	dev-perl/Time-Duration
	dev-perl/Crypt-SSLeay"
