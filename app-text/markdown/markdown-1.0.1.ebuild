# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# From bug #145270 . Had been in Sunrise, but dev incorrectly claimed it's in
# CPAN.

EAPI=5

MY_P=${PN/m/M}_${PV}

DESCRIPTION="Text-to-HTML conversion tool"
HOMEPAGE="http://daringfireball.net/projects/markdown/"
SRC_URI="http://daringfireball.net/projects/downloads/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/perl
	virtual/perl-Digest-MD5"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	dobin Markdown.pl
	dosym Markdown.pl /usr/bin/markdown
	newdoc 'Markdown Readme.text' readme.txt
}
