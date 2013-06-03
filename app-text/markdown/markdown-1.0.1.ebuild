# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# From bug #145270 . Had been in Sunrise, but dev incorrectly claimed it's in
# CPAN.

EAPI=3

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
	dobin Markdown.pl || die "installing binary failed"
	dosym Markdown.pl /usr/bin/markdown || die "installing symlink failed"
	dodoc 'Markdown Readme.text' || die "installing doc failed"
}
