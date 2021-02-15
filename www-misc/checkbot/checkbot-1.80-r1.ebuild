# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DIST_AUTHOR="JJDG"

inherit perl-module

DESCRIPTION="WWW link verifier"
HOMEPAGE="https://degraaff.org/checkbot/ https://sourceforge.net/projects/checkbot/"

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
