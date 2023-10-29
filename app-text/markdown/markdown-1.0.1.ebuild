# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# From bug #145270 . Had been in Sunrise, but dev incorrectly claimed it's in
# CPAN.

EAPI=7

MY_P=${PN/m/M}_${PV}

DESCRIPTION="Text-to-HTML conversion tool"
HOMEPAGE="https://daringfireball.net/projects/markdown/"
SRC_URI="https://daringfireball.net/projects/downloads/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

DEPEND="dev-lang/perl
	virtual/perl-Digest-MD5"
RDEPEND="${DEPEND}"
BDEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_P}"

src_install() {
	dobin Markdown.pl
	dosym Markdown.pl /usr/bin/markdown
	newdoc 'Markdown Readme.text' readme.txt
}
